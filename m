From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 37/38] pack v4: introduce "escape hatches" in the name and
 path indexes
Date: Fri, 6 Sep 2013 06:57:02 +0700
Message-ID: <CACsJy8CyXNEc113U1cDbS3uR18sbALU4Uu_ULf_+EpYhwVdCmg@mail.gmail.com>
References: <1378362001-1738-1-git-send-email-nico@fluxnic.net>
 <1378362001-1738-38-git-send-email-nico@fluxnic.net> <alpine.LFD.2.03.1309051445140.14472@syhkavp.arg>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Fri Sep 06 01:57:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VHjQf-0000HY-57
	for gcvg-git-2@plane.gmane.org; Fri, 06 Sep 2013 01:57:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753246Ab3IEX5d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Sep 2013 19:57:33 -0400
Received: from mail-oa0-f42.google.com ([209.85.219.42]:49734 "EHLO
	mail-oa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753097Ab3IEX5c (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Sep 2013 19:57:32 -0400
Received: by mail-oa0-f42.google.com with SMTP id n12so3211361oag.15
        for <git@vger.kernel.org>; Thu, 05 Sep 2013 16:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=6Tzw/WRzhZOv3SfuMlA8L1jjDI5aeWiRvjZJS0mQldk=;
        b=SN7xPCyDkhdbexym0OAnLttzh+JWfiN8scnM1Ftx34Ley+SgZ05Nv8M+sDN1thhgaj
         zG6Ij9IcKEV4iE+PLmD3mlpTOFqAQKmv4LX5l4orYlSh2Ku4zu28XHTSU42YhYww07TG
         wbvX3FGIWop57MhaGA0RLQhgs/1mFLw/fzQzu28Fh1mRU2eoDVHvGpbef9oZp4LVsZZq
         0nAtH6oR14zAfdAI0E3sr+TdqVRaN9Us/VIpZMcqnlcg5pQQ4DpAl2b/QVW7YProhDZa
         y/4okCrnSm77TNYVuNIx4PtGpT8VhhweoGx//LXqeD2GDQgRI0UAtaBTnc0zIhfzHj4n
         P+RQ==
X-Received: by 10.182.134.229 with SMTP id pn5mr8033131obb.88.1378425452089;
 Thu, 05 Sep 2013 16:57:32 -0700 (PDT)
Received: by 10.182.87.105 with HTTP; Thu, 5 Sep 2013 16:57:02 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.03.1309051445140.14472@syhkavp.arg>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234007>

On Fri, Sep 6, 2013 at 2:02 AM, Nicolas Pitre <nico@fluxnic.net> wrote:
> I think that we've found a way to better support thin packs.
>
> You said:
>
>> What if the sender prepares the sha-1 table to contain missing objects
>> in advance? The sender should know what base objects are missing. Then
>> we only need to append objects at the receiving end and verify that
>> all new objects are also present in the sha-1 table.
>
> So the SHA1 table is covered.
>
> Missing objects in a thin pack cannot themselves be deltas.  We had
> their undeltified form at the end of a pack for the pack to be complete.
> Therefore those missing objects serve only as base objects for other
> deltas.
>
> Although this is possible to have deltified commit objects in pack v2, I
> don't think this happens very often. There is no deltified commit
> objects in pack v4.
>
> Blob objects are the same in pack v2 and pack v4.  No dictionary
> references are needed.
>
> That leaves only tree objects.  And because we've also discussed the
> need to have non transcoded object representations for those odd cases
> such as zero padded file modes, we might as well simply use that for the
> appended tree objects already needed to complete a thin pack.  At least
> the strings in tree entries will be compressed that way.
>
> Problem solved, and one less special case in the code.
>
> What do you think?

Agreed.

>  Please also remove this from your documentation patch.

Will do.
-- 
Duy
