From: Phil Hord <phil.hord@gmail.com>
Subject: Re: Git tag output order is incorrect (IMHO)
Date: Wed, 11 Sep 2013 09:42:27 -0400
Message-ID: <CABURp0o5tOswiv_avfAQOZwGREpX3v7MwcdVzt7dkubY2Y0O6g@mail.gmail.com>
References: <840FACA0-7E13-41DB-A0F8-124FAB53BFBD@rtcamp.com> <CAMP44s3p_DRTvBhKbM0ejKgea9hauSCzahPux4jCWL7JP4nxKw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Rahul Bansal <rahul.bansal@rtcamp.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 11 15:43:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJkh9-000877-KC
	for gcvg-git-2@plane.gmane.org; Wed, 11 Sep 2013 15:43:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754153Ab3IKNmv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Sep 2013 09:42:51 -0400
Received: from mail-ve0-f176.google.com ([209.85.128.176]:57544 "EHLO
	mail-ve0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752663Ab3IKNmt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Sep 2013 09:42:49 -0400
Received: by mail-ve0-f176.google.com with SMTP id jx11so5593463veb.21
        for <git@vger.kernel.org>; Wed, 11 Sep 2013 06:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=Za0ALWpTivgswIDojVnIxRV8riEt4bPkXX81l+yiTow=;
        b=HiflSr9ofKYNYsnR1aVu502Ti3GTy5g1icqOc9M+QI3+O8CoCA4jkvvaWKr047K3dr
         wDvDYco0nwfw9g52NuxNvqbLk1aoOid6ReOrPFCWNHsLgd5Z1XfbILC6hdtMRuLVW9na
         lDLIc7IRdrDANCT/9U1rJhwhiZO0pAwPWqdy6uUB2nxW9s5wy4BNVs9UcVHwwgGtPsW8
         p77t/uh1OT+jmEbRYLCH0OcYWqenV1ZDP5Mp1Cf0sqJ3ffGlm74guv4yw/z/oOtV34O+
         7fOtgfwoLnI2D4m/l+8ym8VJ++YdurHAp0exrVWzRX9H+5DpR+nB08Ww6UOgSEA6d5ls
         PHog==
X-Received: by 10.58.161.116 with SMTP id xr20mr1345691veb.2.1378906967897;
 Wed, 11 Sep 2013 06:42:47 -0700 (PDT)
Received: by 10.58.49.197 with HTTP; Wed, 11 Sep 2013 06:42:27 -0700 (PDT)
In-Reply-To: <CAMP44s3p_DRTvBhKbM0ejKgea9hauSCzahPux4jCWL7JP4nxKw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234565>

Someone at $work asked me this week how to find the current and
previous tags on his branch so he could generate release notes.  I
just need "last two tags on head in topo-order". I was surprised by
how complicated this turned out to be. I ended up with this:

  git log --decorate=full --pretty=format:'%d' HEAD |
    sed -n -e 's-^.* refs/tags/\(.*\)[ )].*$-\1-p' |
    head -2

Surely there's a cleaner way, right?

Phil



On Sun, Sep 8, 2013 at 6:49 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> On Thu, Jul 18, 2013 at 10:27 AM, Rahul Bansal <rahul.bansal@rtcamp.com> wrote:
>> I am posting here first time, so please excuse me if this is not right place to send something like this.
>>
>> Please check - http://stackoverflow.com/questions/6091306/can-i-make-git-print-x-y-z-style-tag-names-in-a-sensible-order
>>
>> And also - https://github.com/gitlabhq/gitlabhq/issues/4565
>>
>> IMHO "git tag" is expected to show tag-list ordered by versions.
>>
>> It may be case, that people do not follow same version numbering convention. Most people after x.9.x increment major version (that is why they may not be affected because of this)
>>
>> Another option like "git tag --date-asc" can be added which will print tags by creation date. (As long as people do not create backdated tag, this will work).
>
> I completely agree, and there was a proposal to an option like this a
> long time ago:
>
> http://article.gmane.org/gmane.comp.version-control.git/111032
>
> --
> Felipe Contreras
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
