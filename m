From: David Hagood <david.hagood@gmail.com>
Subject: Git under Windows should warn or fail on entities differning only
 in case
Date: Fri, 12 Feb 2010 06:40:33 -0600
Message-ID: <1265978433.7519.6.camel@chumley>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 12 13:40:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NfupC-00071p-9F
	for gcvg-git-2@lo.gmane.org; Fri, 12 Feb 2010 13:40:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754491Ab0BLMki (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Feb 2010 07:40:38 -0500
Received: from mail-iw0-f201.google.com ([209.85.223.201]:33235 "EHLO
	mail-iw0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751323Ab0BLMkh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Feb 2010 07:40:37 -0500
Received: by iwn39 with SMTP id 39so560787iwn.1
        for <git@vger.kernel.org>; Fri, 12 Feb 2010 04:40:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:subject:from:to
         :content-type:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        bh=lOeAQDDgwzXnILA0O216klzDCKbv537th6DC2BUkn50=;
        b=ZdfVLtoSNCzce1A3iwipbOgxZRxAEW8KWAcqe9yMiBuRlVzWtam7fTQr9Q6jUtOWZS
         nqE+4GxI4pAjNxK02y4oQplpXGybWiI0/CdhCDVKbvVktxM+3QFAJH5XyKrPSPsgJ9Hw
         Fq1AU4SM9g3H9i2CzMlEMDNzeqBc3xk9KQX4I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:to:content-type:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=D/g5BuJgfwN1cYMr+E+/vY0XFi5RG+/uVzIJPWouKfIT5h+hSHspbhvWbWSqTHu9FN
         seFVXLu95C1EpsRZ+QptRSnQp1dUwRVAmB5Tpg/h/jfXtlf0ycalmnXL0x9K7eAf0Gq4
         tLYie1qhkDpsl3/e80/LywmQtxY7tg7pdw1eM=
Received: by 10.231.169.145 with SMTP id z17mr853604iby.83.1265978436737;
        Fri, 12 Feb 2010 04:40:36 -0800 (PST)
Received: from Deathwish.hagood.sktc.net (7206-2.clr.64.71.120.40.clradsl.sktc.net [64.71.120.40])
        by mx.google.com with ESMTPS id 21sm2952241iwn.14.2010.02.12.04.40.35
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 12 Feb 2010 04:40:36 -0800 (PST)
Received: from [10.16.0.66] (chumley.hagood.sktc.net [10.16.0.66])
	by Deathwish.hagood.sktc.net (Postfix) with ESMTP id 39F38C7B8042
	for <git@vger.kernel.org>; Fri, 12 Feb 2010 06:40:34 -0600 (CST)
X-Mailer: Evolution 2.28.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139697>

I work in a mixed Windows and Linux development team where we have an
embedded project that we are storing in GIT. However, we got bit by what
is arguably a bug in Windows, but...

If you have 2 entities in a directory which have names differing only in
case, e.g. "foo" and "FOO", under a REAL operating system with case
sensitive file system semantics, this is no problem. However, under
Windows and their wonderful "Case preserving but case insensitive"
semantics, "FOO" and "foo" would be the same file, so when you
pull/checkout/clone a repo with this condition, Windows will overwrite
one file, then Git will always see a "change" because one file or the
other won't be "right".

I would suggest that git should check for this case, and generate a big
warning about it when it happens. (Yes, it sucks burdening Git with
Windows' problems....)
