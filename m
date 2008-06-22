From: Jakub Narebski <jnareb@gmail.com>
Subject: git log --follow <filename> doesn't follow across 'subtree strategy' merge
Date: Sun, 22 Jun 2008 14:51:49 +0200
Message-ID: <200806221451.50624.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 22 14:49:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KAP0Q-0002FB-In
	for gcvg-git-2@gmane.org; Sun, 22 Jun 2008 14:49:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751745AbYFVMsX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Jun 2008 08:48:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751401AbYFVMsX
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Jun 2008 08:48:23 -0400
Received: from an-out-0708.google.com ([209.85.132.249]:61232 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751739AbYFVMsW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jun 2008 08:48:22 -0400
Received: by an-out-0708.google.com with SMTP id d40so485551and.103
        for <git@vger.kernel.org>; Sun, 22 Jun 2008 05:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=tAcBX7AoaGl4MdFzwE28KAhgOfkKtRW4Y9krSdtwbTE=;
        b=dXOkRphEuBlXnmA71SJa8uEdxhcwjSMbZKNEaTo7ok2mPz3hmBZSTtEswR1vBB6VL6
         xoGenLmc5PitnCuH7H36iHiJGBi1ZnRKwHhcHdfDacykeJDbGXmd7/i8hlBiDWzs87Au
         w45NN76pWBF0hOnTT8CcWcSE0hmPJr9IdV+T4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        b=VzJTOMaimYLgpfExkROxwP7g9Z8/BHheQAOqyv/O5JfFyqISWLbJ9qy5tILdAY75g6
         OgA6U1mcJrbjD6WZ2rgMWhQKSDkvfg+JxqzSWlWL8zu46D0j7BInz77HR+H3wWGegsWF
         w5oQS5CcCnygqgNQa7+taOXY4uDlo2J7WZwnE=
Received: by 10.101.67.11 with SMTP id u11mr10503291ank.118.1214138901703;
        Sun, 22 Jun 2008 05:48:21 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.226.228])
        by mx.google.com with ESMTPS id c30sm8530376ana.27.2008.06.22.05.48.19
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 22 Jun 2008 05:48:20 -0700 (PDT)
User-Agent: KMail/1.9.3
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85766>

When trying to see all history of gitweb using

  $ git log -C -C --raw --abbrev --follow gitweb/gitweb.perl

I have noticed that while it correctly detects renaming 
gitweb/gitweb.cgi to gitweb/gitweb.perl, and follows this rename, it 
cannot get past merge commit 0a8f4f0020cb35095005852c0797f0b90e9ebb74
and follow moving gitweb.cgi to gitweb/gitweb.cgi.

To get full history I have to use

  $ git log -C -C --raw -- gitweb/gitweb.perl gitweb/gitweb.cgi \
                           gitweb.cgi

Adding '--full-history' doesn't help...
-- 
Jakub Narebski
Thorn, Poland
ShadeHawk on #git
