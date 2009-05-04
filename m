From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: Wrong conflicts on file splits
Date: Mon, 4 May 2009 09:52:47 -0400
Message-ID: <9e4733910905040652s60f0a229qef18b36d386905ee@mail.gmail.com>
References: <9e4733910905040553u377ab11n1609d980021be498@mail.gmail.com>
	 <49FEED2C.8010501@drmicha.warpmail.net>
	 <9e4733910905040642h5932e80ds5c467db90e03f40d@mail.gmail.com>
	 <49FEF25A.3090305@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon May 04 15:53:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M0ybI-0001aX-Ua
	for gcvg-git-2@gmane.org; Mon, 04 May 2009 15:52:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754885AbZEDNwt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 May 2009 09:52:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751567AbZEDNwt
	(ORCPT <rfc822;git-outgoing>); Mon, 4 May 2009 09:52:49 -0400
Received: from mail-ew0-f224.google.com ([209.85.219.224]:55079 "EHLO
	mail-ew0-f224.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751346AbZEDNws (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 May 2009 09:52:48 -0400
Received: by ewy24 with SMTP id 24so3931164ewy.37
        for <git@vger.kernel.org>; Mon, 04 May 2009 06:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=3E2RJFKOwAyXYUZB7QKkBHz+WQx2YL7gXxBAuL3OVAE=;
        b=VPE7pSCkEr5Xc95hyZAqvIQtW6GcAp/iSVm+GM8xQCEBpO6/YJxNebQ8w+7lStdUdA
         zVCip45R+zoWmre45KtYdelqmsJzOlhOzXj78HbysUCW9bLQ/OtlmAP136jQwp2aV/i5
         86OeNNIjYmY0cZEEj8PuJ0tuoIWpv5rIHqeM8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=HnfPT2q/7wxZB3isgG3M106VBVWEKP1n5QA15PAjozOSeY9wiGYyWnzKiJfKWjO7On
         VxK0UIoy8wXOm/TyKwuyeb1hZEf+kyA66nQXFIJ8ACX5f6JlA25sGdY7RWpSmPt36ic9
         kMZ/q1bOyMn1K38h1tyax3kA5qsowqn3/Bvus=
Received: by 10.220.45.79 with SMTP id d15mr9322325vcf.48.1241445167399; Mon, 
	04 May 2009 06:52:47 -0700 (PDT)
In-Reply-To: <49FEF25A.3090305@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118238>

On Mon, May 4, 2009 at 9:49 AM, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
> Jon Smirl venit, vidit, dixit 04.05.2009 15:42:
>> On Mon, May 4, 2009 at 9:27 AM, Michael J Gruber
>> <git@drmicha.warpmail.net> wrote:
>>> Jon Smirl venit, vidit, dixit 04.05.2009 14:53:
>>>> I keep running into this problem, is there anything I can do to make
>>>> it better? I'm using stgit but this is a problem in git itself.
>>>>
>>>> I have a patch that splits file A into two files, A and B.
>>>> Now I merge with another tree and bring in a one line fix to A.
>>>> The fix touches the pre-split file A in a section that is going to end up in B.
>>>> Next I re-apply the patch that splits A into A and B.
>>>>
>>>> This results in a large conflict in the post split file A.
>>>> And no patch being applied to file B which is where the fix belongs.
>>>>
>>>> Repeat this process with a multi-line fix and the whole automated
>>>> merge process breaks down and I have to carefully figure everything
>>>> out by hand.
>>>>
>>>> The merge process seems to be unaware of the newly created file B. No
>>>> patches or conflict ever end up in it.
>>>>
>>>
>>> Can you provide a test case or at least a list of commands which you are
>>> issuing? You complain about "merge", but you say you are "applying a
>>> patch". Are you merging that patch from another branch, or are you
>>> really applying it as a patch (git-apply/cherry-pick/rebase/what-not)?
>>
>> What git command does stgit use internally on push/pop?
>>
>> It's the stg push of a patch creating a split on top of a change to
>> the section that is going to end up in file B that causes the problem.
>
> I see. So it's really rebasing/applying here rather then merging. I
> don't think they have the necessary info in order to do content-based
> patching across file boundaries.

Are there git commands that can do this properly? stgit is just a
bunch of Python executing git commands, they can change which commands
are getting called.

>
> Michael
>



-- 
Jon Smirl
jonsmirl@gmail.com
