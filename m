From: James Pickens <jepicken@gmail.com>
Subject: 'git status' on NFS performance regression in 1.7.0
Date: Wed, 17 Feb 2010 13:08:12 -0700
Message-ID: <885649361002171208j41405b9exdfc34034c905e96c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git ML <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Feb 17 21:16:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NhqJW-0000nF-6r
	for gcvg-git-2@lo.gmane.org; Wed, 17 Feb 2010 21:16:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754855Ab0BQUPz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Feb 2010 15:15:55 -0500
Received: from mail-yw0-f197.google.com ([209.85.211.197]:48546 "EHLO
	mail-yw0-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754846Ab0BQUPy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Feb 2010 15:15:54 -0500
Received: by ywh35 with SMTP id 35so257106ywh.4
        for <git@vger.kernel.org>; Wed, 17 Feb 2010 12:15:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:from:date:message-id
         :subject:to:content-type;
        bh=wELCMyH8nv4RQIt9GJ1tDzGFSGqgdxmrowoNYWzmURI=;
        b=LkNfk84FiCeNY4z8PTNMKOLrKms4e/9rxLz9Ppomo8lQGeT2vUk7Hhvn+zxyVRQuhD
         r4Mk+yM4lYuVdYphrVlpGuaQL5WyL03WTQR6WDl/FTBeXnkXRBIgQqgIp44wcycTLTpr
         fhAMigTbLFPSBO63fTMTIL5TCaS4WXLI+LZcU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        b=ATQaD+l31ikZ/KUFSXQv2EoHW4A2koJP5cUvfaW59MY05iaIGiVNM2CajokkbVl59r
         2Hy88VHE0V894Dizgamia5r4fIa8yQwKgSIvHXPNelEet9mFdue+fvdUSGeeiCIwW73F
         Ox8iaeZFl4E1syNi8EMaXgwqG625On9QkNzbM=
Received: by 10.91.97.14 with SMTP id z14mr2946491agl.0.1266437313042; Wed, 17 
	Feb 2010 12:08:33 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140258>

Hi,

I noticed that 'git status' in version 1.7.0 is much slower than in 1.6.2.5
on large work trees on NFS - averaging ~13 seconds runtime vs. ~2 seconds.
I did a bit of debugging and found that 'git status' apparently doesn't use
the multi-threaded preload_index any more, although some other commands
like diff still use it.  Was it intentionally dropped from 'git status'?

James
