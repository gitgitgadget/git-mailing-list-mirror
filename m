From: Knittl <knittl89@googlemail.com>
Subject: Re: [PATCH re-roll] Do not display 'Switched to a new branch' when
 the branch existed
Date: Tue, 24 Aug 2010 08:50:41 +0200
Message-ID: <AANLkTim7DNasVmaBxWBcUGyGBCZq_HXNdq_=4uKRdxE-@mail.gmail.com>
References: <AANLkTimaZF1Q6BPB7CN0Wa5-Ov2ejVfPsmL34vps2VqK@mail.gmail.com>
 <AANLkTi=3z9gJdT8LL3NANFyppUjvOVcrszjf5J5zAKPe@mail.gmail.com>
 <20100818091603.GA6263@burratino> <AANLkTikHbj4zA6Kj0wUp6uQUY3w6cM_z0=Pes1jLLTky@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 24 08:51:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OnnLh-0007pu-3l
	for gcvg-git-2@lo.gmane.org; Tue, 24 Aug 2010 08:51:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754058Ab0HXGvD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Aug 2010 02:51:03 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:45168 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751805Ab0HXGvC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Aug 2010 02:51:02 -0400
Received: by vws3 with SMTP id 3so176369vws.19
        for <git@vger.kernel.org>; Mon, 23 Aug 2010 23:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=3g2Po9mbUoKtnhbhmtjXkg3jRqIANXM2P+Ay5zT56zA=;
        b=bUes9l9lBdEmabBxiCVIqUnEl+q6g6EOpIr+ujb4+RBYSOFR7M70+l4IHX/Fvxla+r
         Ccgo2SH4nMPDnts1yw41DvZpy18E9nfEM4BDDHkgrpKA345m4Zp7gmrsJhC+XVMPswlJ
         NdUY+VlM39bWoAE96cfz4TAB2Q8C+RRzvwfVg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=oGHmsCI/ArXQ1HxeuRTKcRt2Z2DFeq0158OOm8irABiB8NwRb2wQp3KbUUl5oMfwbm
         byS8HAsLoNCrhQyF7lxxSQ1C3igyjA8xlL9wDZJCj6R3+/MJLuQxLdSj9Wg5HZI5/m+L
         2b2rHixM6O92uJomWJ05tLxWRANchvrER4WNI=
Received: by 10.220.124.33 with SMTP id s33mr3794414vcr.159.1282632661102;
 Mon, 23 Aug 2010 23:51:01 -0700 (PDT)
Received: by 10.220.177.77 with HTTP; Mon, 23 Aug 2010 23:50:41 -0700 (PDT)
In-Reply-To: <AANLkTikHbj4zA6Kj0wUp6uQUY3w6cM_z0=Pes1jLLTky@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154298>

sorry for the late reply, i hadn't had access to internet for the last
week and as it turns i sent my response only to tay

On Wed, Aug 18, 2010 at 3:39 PM, Tay Ray Chuan <rctay89@gmail.com> wrote:
> Hi,
>
> On Wed, Aug 18, 2010 at 5:16 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> [snip]
>
>> The "From " line and so on output by "git format-patch" are for your
>> mailer.  Clarifying From:, Date:, and Subject: lines at the start of
>> your message are allowed, though, and can be useful when forwarding
>> patches from someone else.
>
> Knittl, I wonder how you generated this patch? Were you working on top
> of the "bad" commit?

yes, i branched off of your bad commit (or rather the commit after
your bad commit "fix detached head usage") and created the commit with
git commit -c HEAD^ to have the same heading and similar wording
without opening a second terminal to copy it over. so i accidentally
sent the patch with your name as author, which i then fixed with git
amend --reset-author

>>> +++ b/builtin/checkout.c
>>> @@ -536,7 +536,9 @@ static void update_refs_for_switch(struct
>>> checkout_opts *opts,
>>>                                       new->name);
>>>                       else
>>>                               fprintf(stderr, "Switched to%s branch '%s'\n",
>>> -                                     opts->branch_exists ? " and reset" : " a new",
>>> +                                     opts->branch_exists
>>> +                                             ? " and reset"
>>> +                                             : opts->new_branch ? " a new" : "",
>
> Strange - I thought I had this sorted out. Thanks for spotting this.

i tested with next and pu and both tips had the same (confusing) message.

>> Maybe it would be clearer to write
>>
>>        opts->new_branch ? " a new"
>>                : opts->branch_exists ? " and reset"
>>                : "",
>>
>> to emphasize that this is a list of condition/result pairs?
>
> We could do with some parentheses - here's my take:
>
>        fprintf(stderr, "Switched to%s branch '%s'\n",
>                (opts->branch_exists ? " and reset" :
>                        (opts->new_branch ? " a new" : "")),
>                new->name);

that's not really for me to decide, but i'm fine with either version

cheers

-- 
typed with http://neo-layout.org
myFtPhp -- visit http://myftphp.sf.net -- v. 0.4.7 released!
