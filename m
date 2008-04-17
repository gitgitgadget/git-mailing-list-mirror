From: "Lars Hjemli" <hjemli@gmail.com>
Subject: Re: [PATCH v3] git-branch: add support for --merged and --no-merged
Date: Fri, 18 Apr 2008 00:59:54 +0200
Message-ID: <8c5c35580804171559u87f70b6j59d327ca514da714@mail.gmail.com>
References: <7vr6d4nvkm.fsf@gitster.siamese.dyndns.org>
	 <1208463890-2870-1-git-send-email-hjemli@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 18 01:00:51 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jmd5w-0003Gv-8p
	for gcvg-git-2@gmane.org; Fri, 18 Apr 2008 01:00:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754016AbYDQW7z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Apr 2008 18:59:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753686AbYDQW7z
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Apr 2008 18:59:55 -0400
Received: from wa-out-1112.google.com ([209.85.146.183]:46640 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753470AbYDQW7y (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Apr 2008 18:59:54 -0400
Received: by wa-out-1112.google.com with SMTP id m16so437819waf.23
        for <git@vger.kernel.org>; Thu, 17 Apr 2008 15:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=Q2FVCZXL1yseW+8yd+4NLMhkNIvUoCsjp9fRlJyhx5Y=;
        b=EPElZ1JDUiCJG3V7JAnV0Gi6TPYPLB7DDbWyIo3pkhROPevgBLjeGcwozkkhcmCiu8SebDAHAEdVESf1K6P/AYOP9K48dxqjAl15HFjzbBzIqxFoHCWtffnk+JEJntB+ZIEh1oTbk3EVDZy3p8c7FyEIxZ2DLrENSTUkj6Y80QM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=xjOy1HzDJD8MfHNFP4iYvJNgAcJpNv7OUjxMEVVfoGSKtlRmCicGY6Dg8t2RWuswUb7ZDdcys/sygZQQeecRmxmwz62Jgw5ysIfU1O7bq+ZMHtS9RbxoBWj7z60py+lLqU3zTcmS1Hm9cpXOADJXdnlJ+lDDWWLh9iFJICbDNY0=
Received: by 10.115.77.1 with SMTP id e1mr2146510wal.208.1208473194348;
        Thu, 17 Apr 2008 15:59:54 -0700 (PDT)
Received: by 10.114.241.18 with HTTP; Thu, 17 Apr 2008 15:59:54 -0700 (PDT)
In-Reply-To: <1208463890-2870-1-git-send-email-hjemli@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79843>

On Thu, Apr 17, 2008 at 10:24 PM, Lars Hjemli <hjemli@gmail.com> wrote:
> These options filter the output from git branch to only include branches
>  whose tip is either merged or not merged into HEAD.

Gaah, I just noticed a slight terminology slip. Could you please apply
this on top of [PATCH v3]?

(hopefully not mangled by gmail...)

---
diff --git a/builtin-branch.c b/builtin-branch.c
index eecbcf2..19c508a 100644
--- a/builtin-branch.c
+++ b/builtin-branch.c
@@ -237,7 +237,7 @@ static int append_ref(const char *refname
        if (mergefilter > -1) {
                branch.item = lookup_commit_reference_gently(sha1, 1);
                if (!branch.item)
-                       die("Unable to lookup HEAD of branch %s", refname);
+                       die("Unable to lookup tip of branch %s", refname);
                if (mergefilter == 0 && has_commit(head_sha1, &branch))
                        return 0;
                if (mergefilter == 1 && !has_commit(head_sha1, &branch))
