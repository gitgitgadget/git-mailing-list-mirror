From: Xin Wang <dram.wang@gmail.com>
Subject: git calls SSH_ASKPASS even if DISPLAY is not set
Date: Sat, 11 Dec 2010 11:24:28 +0800
Message-ID: <AANLkTinES5dqt+JAMOrp7gAYJ4UgK9ipfEN9ag5qSCLp@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 11 04:33:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PRGCg-0000er-Ip
	for gcvg-git-2@lo.gmane.org; Sat, 11 Dec 2010 04:32:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754226Ab0LKDYa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 10 Dec 2010 22:24:30 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:42887 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753199Ab0LKDYa convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 10 Dec 2010 22:24:30 -0500
Received: by wyb28 with SMTP id 28so4117324wyb.19
        for <git@vger.kernel.org>; Fri, 10 Dec 2010 19:24:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type:content-transfer-encoding;
        bh=Rwzk9JoDgn2n2ErG7Enc/RoIPTw1IJ4UIkrQ/kBq44A=;
        b=Aqj9g78jRG/xQ7+Pu/GP2PnnhUctCZc7EhieTPAG1NDutdz3415efFVftqjsTgGs6l
         aAJy2AvAF8r9Lz0Ul8W01TJtKKLM433qATmCOeW0Cp0XcjlRuhafwA+nlcc4gpwEWVUU
         D13WxN4x3wIi+5JSA1w6FNe1MgxZGQC/NYFK8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=VtCxYOGaUghbJZnivq/d/LRvOrQPtCV16laPCJhcgq4CwuqyI01uRPo+RAwde+U9my
         AO/UdZ0hNGwF7FZ6xz1Ncht6ersWskxrlD4URuyJmJpgexhRJbTSeFwBAMdKqSA0YwBu
         3QWVmB1S/O1UR6hR7GJKVLHOFEGaj2oYATD0Q=
Received: by 10.216.178.137 with SMTP id f9mr1930902wem.81.1292037868741; Fri,
 10 Dec 2010 19:24:28 -0800 (PST)
Received: by 10.216.180.129 with HTTP; Fri, 10 Dec 2010 19:24:28 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163458>

Hi all,

I'm using git 1.7.3.2 in Fedora 14. In Fedora, SSH_ASKPASS will set to
be /usr/libexec/openssh/gnome-ssh-askpass in
/etc/profile.d/gnome-ssh-askpass.sh, so this environment is set by
login shell, and it will still be set even when X11 is not inuse.

According to ssh's manpage: "If ssh does not have a terminal
associated with it but DISPLAY and SSH_ASKPASS are set, it will
execute the program specified by SSH_ASKPASS and open an X11 window to
read the passphrase." But git will call SSH_ASKPASS even if there is a
terminal associated with it and DISPLAY is not set, then following
warning is displayed and git failed to go through.

$ git fetch

(gnome-ssh-askpass:1487): Gtk-WARNING **: cannot open display:

I think it=91s better if git could implement behavior conforming to ssh=
=2E


Thanks,
Xin Wang
