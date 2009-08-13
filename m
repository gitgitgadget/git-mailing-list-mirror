From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [RFC PATCH v3 8/8] --sparse for porcelains
Date: Thu, 13 Aug 2009 14:20:56 +0700
Message-ID: <fcaeb9bf0908130020meaed129j5d6a4f04a6878bd0@mail.gmail.com>
References: <1250005446-12047-1-git-send-email-pclouds@gmail.com> 
	<1250005446-12047-2-git-send-email-pclouds@gmail.com> <1250005446-12047-3-git-send-email-pclouds@gmail.com> 
	<1250005446-12047-4-git-send-email-pclouds@gmail.com> <1250005446-12047-5-git-send-email-pclouds@gmail.com> 
	<1250005446-12047-6-git-send-email-pclouds@gmail.com> <1250005446-12047-7-git-send-email-pclouds@gmail.com> 
	<1250005446-12047-8-git-send-email-pclouds@gmail.com> <1250005446-12047-9-git-send-email-pclouds@gmail.com> 
	<7v3a7xa6e5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 13 09:21:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MbUcr-0005Hy-1l
	for gcvg-git-2@gmane.org; Thu, 13 Aug 2009 09:21:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753277AbZHMHVQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Aug 2009 03:21:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753122AbZHMHVQ
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Aug 2009 03:21:16 -0400
Received: from mail-yx0-f175.google.com ([209.85.210.175]:50023 "EHLO
	mail-yx0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752491AbZHMHVP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Aug 2009 03:21:15 -0400
Received: by yxe5 with SMTP id 5so753172yxe.33
        for <git@vger.kernel.org>; Thu, 13 Aug 2009 00:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=42nRWbhEdIOnKiVaQO5hTFPVuj7xe/vF7MtPjfJCdwY=;
        b=TvvLggjfQyp+Rr6UKkIYeGLsh3xon4l346Zq+aRI7aoghA5Nq4rPs43D1j5Mn541YO
         Z84TNstJ2+5z6VRVTemiUqG/rswOFGO9aOzi8jbER5phnV2xTQLaQqIQtZJMMc0go2TD
         vNAGtKsGnM9E/C9SdzciewORzEcFQmTITYmkQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=pPGQfh6v2qE+n1fCKUD7S6VdkLAViBBJnfbFGs9ah+OxssKCGY1sHjKx1ZHQGYuxQw
         Q0BC7i6Wstpcmi3liuttMoXpOZMSKPoB0GUA+glaDiIa17wP6Fg9XMuJSbrTpghVSxIJ
         rHEMgyymoEkyVEdsSek0CFQPwIf0VI13Szj5w=
Received: by 10.100.174.2 with SMTP id w2mr717368ane.114.1250148076205; Thu, 
	13 Aug 2009 00:21:16 -0700 (PDT)
In-Reply-To: <7v3a7xa6e5.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125788>

2009/8/12 Junio C Hamano <gitster@pobox.com>:
> It could also require core.sparseworktree configuration set to true if we
> are really paranoid, but without the actual sparse specification file
> flipping that configuration to true would not be useful anyway, so in
> practice, giving --sparse-work-tree option to these Porcelain commands
> would be no-op, but --no-sparse-work-tree option would be useful to
> ignore $GIT_DIR/info/sparse and populate the work tree fully.

Only part "ignore $GIT_DIR/info/sparse" is correct.
"--no-sparse-work-tree" would not clear CE_VALID from all entries in
index (which is good, if you are using CE_VALID for another purpose).

To quit sparse checkout, you must create an empty
$GIT_DIR/info/sparse, then do "git checkout" or "git read-tree -m -u
HEAD" so that the tree is full populated, then you can remove
$GIT_DIR/info/sparse. Quite unintuitive..
-- 
Duy
