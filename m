From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: How safe are signed git tags? Only as safe as SHA-1 or somehow safer?
Date: Mon, 24 Nov 2014 18:44:10 +0700
Message-ID: <CACsJy8B5dbYZm25019avX2q0Ymp=f4jt=jt898M_znE8eEcOVg@mail.gmail.com>
References: <5468C33E.2080108@whonix.org> <20141117212657.GC15880@peff.net>
 <CACsJy8D-W_YrxMgUDScSmkNBKMVpRu_Kc0k6nsfyhmoLg5HBjg@mail.gmail.com> <54730546.7000200@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>,
	Patrick Schleizer <patrick-mailinglists@whonix.org>,
	Git Mailing List <git@vger.kernel.org>,
	whonix-devel@whonix.org, mikegerwitz@gnu.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon Nov 24 12:44:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xss4U-0007gM-Km
	for gcvg-git-2@plane.gmane.org; Mon, 24 Nov 2014 12:44:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751276AbaKXLom (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Nov 2014 06:44:42 -0500
Received: from mail-ie0-f178.google.com ([209.85.223.178]:63808 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750966AbaKXLol (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Nov 2014 06:44:41 -0500
Received: by mail-ie0-f178.google.com with SMTP id tp5so8390883ieb.23
        for <git@vger.kernel.org>; Mon, 24 Nov 2014 03:44:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=5706yQdw2eAjcdlCvNp1v479x3VTDIIBDMi4GQCVRMI=;
        b=G+/b/d6YJFKvfhfdRKmOsKN774aFBK2reUjFvancAW4vUl+HK8mvP3KIw/jxW3Guy5
         xpAAqcxLNJ8CUTxU/iUWAbHQdQfQBMnU/5l6Fu/VJp+Y9yMXPtQmrpLjTPlz8oF/q9Se
         ekJn6gTuOVUP5/6a5RVOuBO/LZu5/OqjCe/7u3D7CpbkWepyB7UHQRh4bzisqmxyIOG4
         bdOkrayIwuxsrQZkpRpzbgJFJxy6oetm803TdUC9moZnoRLmf+NATGQzyfAcxq9JygbM
         8sTfNKgIJ/yTBRZmlo+1GDSCBHwi9E4RvfH8ju2n1mcQ87AjLJD/oZ+RmywlbSK3pGSt
         i5hw==
X-Received: by 10.107.135.34 with SMTP id j34mr15617614iod.84.1416829480975;
 Mon, 24 Nov 2014 03:44:40 -0800 (PST)
Received: by 10.107.176.8 with HTTP; Mon, 24 Nov 2014 03:44:10 -0800 (PST)
In-Reply-To: <54730546.7000200@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260123>

On Mon, Nov 24, 2014 at 5:15 PM, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
> Duy Nguyen schrieb am 24.11.2014 um 02:23:
>> On Tue, Nov 18, 2014 at 4:26 AM, Jeff King <peff@peff.net> wrote:
>>> Yes, it is only as "safe as SHA-1" in the sense that you have GPG-signed
>>> only a SHA-1 hash. If somebody can find a collision with a hash you have
>>> signed, they can substitute the colliding data for the data you signed.
>>
>> I wonder if we can have an option to sign all blob content of the tree
>> associated to a commit, and the content of parent commit(s). It's more
>> expensive than signing just commit/tag content. But it's also safer
>> without completely ditching SHA-1.
>>
>
> This amounts to hashing the blob content with whatever hash you told
> your gpg to use (hopefully not sha1 ;) ) and signing that.
>
> You're free to do that now and store the signature wherever your
> toolchain deems fit, say in a note or an annotated tag. But that
> approach won't sign the history, that is: If you are concerned about the
> breakability of sha1, then history is "possibly broken" no matter how
> you sign a commit object whose "parent" entry is based on the sha1 of
> its parent object.

If you store the singature in commit message, and if you hash the
parent commit messages as well, which are also signed, then you have
the same chaining effect that we have with SHA-1. I think this could
be done with some hooks already, except maybe for the verification
part.
-- 
Duy
