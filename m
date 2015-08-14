From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH 01/10] ref-filter: add option to filter only branches
Date: Sat, 15 Aug 2015 00:15:56 +0530
Message-ID: <CAOLa=ZTiVftC51e+dpq1=Ui38L5bUseq0M0+vMJ3O-Db9311XQ@mail.gmail.com>
References: <CAOLa=ZSnn19DR_Y5MqUXHed0g5MSk_dwFc48dk8GoPYvL5DQ=Q@mail.gmail.com>
 <1438693282-15516-1-git-send-email-Karthik.188@gmail.com> <xmqqpp2tspb6.fsf@gitster.dls.corp.google.com>
 <CAOLa=ZRRU4htKgB46g0FAGVEGGFN+1N1250AOYJh7H5apv=RJQ@mail.gmail.com>
 <CAOLa=ZQic2=z6bJ0Ykhn2x8mE86w4HwBrJP7pb_RaemGKCZzmQ@mail.gmail.com>
 <CAOLa=ZQSVCgcuUQFsF2Mq-m+wS8im3t4Z3PSEgoAHcV0gGuvPA@mail.gmail.com> <xmqq614hkgnd.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 14 20:46:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZQJzr-00071x-Ns
	for gcvg-git-2@plane.gmane.org; Fri, 14 Aug 2015 20:46:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751652AbbHNSq1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Aug 2015 14:46:27 -0400
Received: from mail-ob0-f173.google.com ([209.85.214.173]:35189 "EHLO
	mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750702AbbHNSq0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Aug 2015 14:46:26 -0400
Received: by obbop1 with SMTP id op1so68704004obb.2
        for <git@vger.kernel.org>; Fri, 14 Aug 2015 11:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=namQQ/zNt7NHCdPvMYObdbsDi5us3Rn/WlH/OAKssac=;
        b=yAJHUcuGJu/3dzcfeTf3/P798Aq4ovNrdOLDKbE5FFTFe2DO+RJsh4dwHsIdPOhCfW
         HiHQ2Nc7kO4AjqP6eWgdNO8hPC90Rwiru9m1hMZxzm4xU+8cSKoAB9KOJODxaPw7BpiM
         vrsHWRyeiZgXxvUooGrg4HGu2/hpeDHnCZ1klakZ3YxzSLaXxZ95Go1txWgbD/GAo1WK
         cfxm8SaW18qkGn/Jz8t7YyX1ueaE+DSPtNjQVMhPjkZCdMIiT+XqqxFG4a2DMCxS8FYg
         i8GmRzoFK1MtyNwkVfEBGe1V4jZhu7kvQi5Mkbt9K8KxMMp7iKcCL59XEX+GaB5hocNR
         t5eg==
X-Received: by 10.182.153.161 with SMTP id vh1mr40132835obb.34.1439577985778;
 Fri, 14 Aug 2015 11:46:25 -0700 (PDT)
Received: by 10.182.59.102 with HTTP; Fri, 14 Aug 2015 11:45:56 -0700 (PDT)
In-Reply-To: <xmqq614hkgnd.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275923>

On Fri, Aug 14, 2015 at 9:26 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> On Thu, Aug 13, 2015 at 5:05 PM, Karthik Nayak <karthik.188@gmail.com> wrote:
>>> On Thu, Aug 13, 2015 at 4:21 PM, Karthik Nayak <karthik.188@gmail.com> wrote:
>>>>
>>>> This was taken from branch.c, I thought of using an enum instead but that
>>>> would again require most of branch.c, hence it's been carried over
>>>> without changing
>>>> I'm thinking of changing it, any suggestions?
>>>>
>>>
>>> What I was thinking was of having:
>>>
>>> #define FILTER_REFS_INCLUDE_BROKEN 0x1
>>> #define FILTER_REFS_TAGS 0x2
>>> #define FILTER_REFS_BRANCHES 0x4
>>> #define FILTER_REFS_REMOTES 0x8
>>> #define FILTER_REFS_DETACHED_HEAD 0x16
>>>
>>> and using these for showing ref kind also instead of separately
>>> having 'REF_DETACHED_HEAD' and so on.
>>>
>>
>> Something like this:
>> https://github.com/KarthikNayak/git/commit/0ec5381420dcdfe7c62000b56168e2842d5d0063
>
> I notice a few things in ref-filter.c in that commit (a web
> interface including GitHub one is horrible in showing the things in
> wider context across files, so I'll base my discussion by guessing
> what the caller of this function and helpers this function calls
> do):
>
>  - Your "ALL" silently overrides others.  Is that sensible?  Perhaps
>    you would instead want to define FILTER_REFS_OTHER (not needed to
>    be exposed to UI) and then define FILTER_REFS_ALL as the ORed
>    value of FILTER_REFS_{BRANCHES,...,OTHER}?
>

Well okay I could something on those lines.

>  - When the caller asks for "--branches --tags", you run
>    ref-filter-handler twice on ref_cbdata.  Does that make sense?
>    Shouldn't you iterate over all the available refs just once,
>    rejecting ones that aren't in either refs/{heads,tags}/ instead?

I was under the idea that since we're dealing with do_for_each_entry()
eventually and in that we set the loose_dir value based on the given 'base'
hence when the caller asks for something like "--branches --tags", it would
be better to just iterate through the refs in the directory of
"--branches --tags"
rather than go through the whole list of refs and drop ones which don't belong
to "--branches --tags". but this was an over the top look at how
do_for_each_entry()
works, I could be totally off the mark.

-- 
Regards,
Karthik Nayak
