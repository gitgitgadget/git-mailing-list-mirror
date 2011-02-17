From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCHv2 1/2] git-patch-id: test for "no newline" markers
Date: Thu, 17 Feb 2011 03:55:46 -0800 (PST)
Message-ID: <m3ei7698qf.fsf@localhost.localdomain>
References: <7vwrkziw2i.fsf@alter.siamese.dyndns.org>
	<d27aa07556df763b34b980d3706320216094d592.1297928549.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	=?iso-8859-15?q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Feb 17 12:55:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pq2Sh-0007pV-Ux
	for gcvg-git-2@lo.gmane.org; Thu, 17 Feb 2011 12:55:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755953Ab1BQLzv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Feb 2011 06:55:51 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:33953 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753152Ab1BQLzu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Feb 2011 06:55:50 -0500
Received: by eye27 with SMTP id 27so1302333eye.19
        for <git@vger.kernel.org>; Thu, 17 Feb 2011 03:55:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:x-authentication-warning:to:cc:subject
         :references:from:date:in-reply-to:message-id:lines:user-agent
         :mime-version:content-type;
        bh=HD0nm7+Er/LuAbhUun1OaqCW0xb3N2692OTO0y1huAg=;
        b=OHUdTMB/TenWwTKk853fkTk9dAQwQ51WrosCvFrSZbe5SVotW+opcc4eivLgQuBATm
         lmN1sTo3pMDS1qa3o+r+C6nFWUEBp2HXvYYC003kDULElRu1dhv+PUAb3Bd97a0LsQbR
         Lp67oK4TXLqQMFWY9lZ+dYSOaMD5lmbmQKXc4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=AOYvccUGjk/TK74ROV/xlliV23NqyP4xFrLcUUTFzqWDgDVejQRGNo5kmap/mIVhNZ
         puAtFI7l6W8JUBjZQeXqkGvP2ck7KXb8mMCcgwG3IbNxRXMDr9xXx4JUGXe02rFx+ViH
         SXcRf74eQQ6ovwSa+MjsGNMgSXjbouGTmf70g=
Received: by 10.14.119.16 with SMTP id m16mr1996279eeh.8.1297943748547;
        Thu, 17 Feb 2011 03:55:48 -0800 (PST)
Received: from localhost.localdomain (abwj70.neoplus.adsl.tpnet.pl [83.8.233.70])
        by mx.google.com with ESMTPS id x54sm785561eeh.23.2011.02.17.03.55.45
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 17 Feb 2011 03:55:46 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id p1HBt7Y7022773;
	Thu, 17 Feb 2011 12:55:18 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id p1HBsnMr022769;
	Thu, 17 Feb 2011 12:54:49 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <d27aa07556df763b34b980d3706320216094d592.1297928549.git.git@drmicha.warpmail.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167068>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> Currently, patch-id trips over our very own diff extension for marking
> the absence of newline at EOF.

This is not *our* diff extension; it is either GNU diff extension, or
it is defined in diff/patch format standard.

diff.info states in chapter "Incomplete Lines":

     When an input file ends in a non-newline character, its last line is
  called an "incomplete line" because its last character is not a
  newline.  All other lines are called "full lines" and end in a newline
  character.  Incomplete lines do not match full lines unless differences
  in white space are ignored (*note White Space::).

     An incomplete line is normally distinguished on output from a full
  line by a following line that starts with `\'. [...]

     For example, suppose `F' and `G' are one-byte files that contain
  just `f' and `g', respectively.  Then `diff F G' outputs

       1c1
       < f
       \ No newline at end of file
       ---
       > g
       \ No newline at end of file

  (The exact message may differ in non-English locales.)

-- 
Jakub Narebski
Poland
ShadeHawk on #git
