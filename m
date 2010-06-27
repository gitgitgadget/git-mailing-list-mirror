From: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>
Subject: [PATCH v4 0/3] CRLF merge conflict reduction, take 4
Date: Sun, 27 Jun 2010 21:43:04 +0200
Message-ID: <cover.1277667177.git.eyvind.bernhardsen@gmail.com>
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Finn Arne Gangstad <finnag@pvv.org>,
	"git@vger.kernel.org List" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jun 27 21:43:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OSxl9-0005ue-Pk
	for gcvg-git-2@lo.gmane.org; Sun, 27 Jun 2010 21:43:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755309Ab0F0TnP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Jun 2010 15:43:15 -0400
Received: from mail-ww0-f46.google.com ([74.125.82.46]:42701 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754088Ab0F0TnO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Jun 2010 15:43:14 -0400
Received: by wwi17 with SMTP id 17so2162397wwi.19
        for <git@vger.kernel.org>; Sun, 27 Jun 2010 12:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=ocROQKkfC34vyLFyxN1/peonkMNETrTVzSETCaMPwHE=;
        b=J5TEHA5/ZKBSdnWWRnYBp2ei4mkpyHT61hpgle1gjshlCVfT68M/nYP7qmnpysKxv6
         mWbskEts8v5Qdno8CHs51WqfIL7I73bA3pSWMBoBBjExDtbp6bO6UOKdIi+f7YdKiULr
         JsPpG59Vtbt55/vsSvzMwWmUa78KbRKaKXEZs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=XeUCbXe8jxVDAzKSodFTcRhX5MKPBOVWHluYUWIgNB2T4MJ8lfAsHbPnXMlpKELdPb
         /WqwwK5K3g+pkJFqClTvR3Vz0vMa+qNSqZGdQqEWsG+h5bjP0DNU51hFhDikIPjy/O5R
         b1ZRZsQ3c4Z2AqYkXx7R1Asc+lZVyH1KhV3Hc=
Received: by 10.227.156.204 with SMTP id y12mr3032570wbw.170.1277667792535;
        Sun, 27 Jun 2010 12:43:12 -0700 (PDT)
Received: from localhost.localdomain (eyvind.bernhardsens.net [84.49.224.5])
        by mx.google.com with ESMTPS id y39sm4411401weq.3.2010.06.27.12.43.11
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 27 Jun 2010 12:43:12 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.575.g383de
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149802>

Only a few changes since the last round:

- added some paragraphs to the filter documentation in gitattributes to
  explain why having normalizing filters is a good thing (comments
  welcome)

- fixed the problem Johannes spotted in the eol=crlf optimization by
  expanding CRLFs (ie not optimizing) if a smudge filter is configured

- moved the opening brace in my function definitions to the next line

Thanks for your input.  I'm pretty happy with this now.
-- 
Eyvind

Eyvind Bernhardsen (3):
  Avoid conflicts when merging branches with mixed normalization
  Try normalizing files to avoid delete/modify conflicts when merging
  Don't expand CRLFs when normalizing text during merge

 Documentation/gitattributes.txt |   27 ++++++++++++++++++
 cache.h                         |    1 +
 convert.c                       |   37 +++++++++++++++++++++----
 ll-merge.c                      |   13 +++++++++
 merge-recursive.c               |   44 ++++++++++++++++++++++++++++-
 t/t6038-merge-text-auto.sh      |   58 +++++++++++++++++++++++++++++++++++++++
 6 files changed, 172 insertions(+), 8 deletions(-)
 create mode 100755 t/t6038-merge-text-auto.sh

-- 
1.7.1.575.g383de
