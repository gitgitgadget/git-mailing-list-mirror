From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH 2/2] tag: do not show ambiguous tag names as "tags/foo"
Date: Tue, 26 Jan 2016 09:55:08 +0530
Message-ID: <CAOLa=ZRWGHf=Q3L6x5wf1Aiy2Q=T2117+YGPxMxM-weYkC+CoQ@mail.gmail.com>
References: <20160124230531.GB29115@sigill.intra.peff.net> <20160124230840.GB16455@sigill.intra.peff.net>
 <xmqq60yhdx4v.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, Pete Harlan <pgit@tento.net>,
	Git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 26 05:25:46 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aNvCJ-0005Z8-UT
	for gcvg-git-2@plane.gmane.org; Tue, 26 Jan 2016 05:25:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753069AbcAZEZj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Jan 2016 23:25:39 -0500
Received: from mail-vk0-f68.google.com ([209.85.213.68]:34748 "EHLO
	mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752057AbcAZEZi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jan 2016 23:25:38 -0500
Received: by mail-vk0-f68.google.com with SMTP id e6so6517237vkh.1
        for <git@vger.kernel.org>; Mon, 25 Jan 2016 20:25:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=8uho3MKp9qvex0qBJ1LTtXHn4WQ9W9XuLjjE/uye9jQ=;
        b=MsPaBSt/fBT5U5nM+hgijz1xnDwi+G9wdWvyb9+T2xwIIhOk13IumwVAVAGlwR0Fao
         llRr1EB+0M/hdCNJtO96vl/LvbLirOKF6eTy3JHPVmzZ8fxDqULEJErPK0yN/IKIku86
         k5d+8hVGVwKQ0KfiOqx6TBry3O0glivFfLMjAHfGF2mTL3DPkSdwsw1SgBdLX9iFhia2
         bqZ6g4IgQLMmQ/WN1EIsv7NSStaAgR2oySwhRnxrpY7FuM9/nT1ulnpRtAAsxXVgM2GJ
         itKYRkXA4+w+z6I7RTgvB0p9AA01ua62DZOyuLa1mbnkVbRXOrdlkUERGbVsUx7VVzUw
         5zCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=8uho3MKp9qvex0qBJ1LTtXHn4WQ9W9XuLjjE/uye9jQ=;
        b=BOnemdWOsEAfzhRTtvD4L8/14mbm4l+n6vyQ6qIvmFQ4rGTO3s6XsTvS2dqiyaUX6V
         /jrNHO6WAuV4dS00NaHzrzPdvE3AsN6wAjbeR8ukX7sA9JBZVn2AmBIGkUjvxBYCbcQV
         yaOBGuERyBX0VNu8boROO3ZbLxWEWDiuAA9b967Q0Rr5SHyIp9yjtSLlJYVyiVyrBLEX
         OnwsFW54DCjmOWEfWh2JYTMzbmMWiSlLypXlb+F+yFhnZgX3/IYvvY7MMMxU6DA7M+IH
         nioWKB4JRXdxLNP+XMMBb3rE7RnHNwEBDswtXqtOoDHW5Iuh7jr+BztsZl6f+S/oIRN1
         84NQ==
X-Gm-Message-State: AG10YOSaK031fQCfxkMlhIHbY897vR5LD8ZFyFs5LyjU1CLHQNMo2Sg4Ib3SUYLovyTzPzEQPrsJjFQ2Cmz4qg==
X-Received: by 10.31.54.75 with SMTP id d72mr3707043vka.30.1453782337602; Mon,
 25 Jan 2016 20:25:37 -0800 (PST)
Received: by 10.103.82.146 with HTTP; Mon, 25 Jan 2016 20:25:08 -0800 (PST)
In-Reply-To: <xmqq60yhdx4v.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284776>

On Tue, Jan 26, 2016 at 5:34 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Jeff King <peff@peff.net> writes:
>
>> Since b7cc53e9 (tag.c: use 'ref-filter' APIs, 2015-07-11),
>> git-tag has started showing tags with ambiguous names (i.e.,
>> when both "heads/foo" and "tags/foo" exists) as "tags/foo"
>> instead of just "foo". This is both:
>>
>>   - pointless; the output of "git tag" includes only
>>     refs/tags, so we know that "foo" means the one in
>>     "refs/tags".
>>
>> and
>>
>>   - ambiguous; in the original output, we know that the line
>>     "foo" means that "refs/tags/foo" exists. In the new
>>     output, it is unclear whether we mean "refs/tags/foo" or
>>     "refs/tags/tags/foo".
>>
>> The reason this happens is that commit b7cc53e9 switched
>> git-tag to use ref-filter's "%(refname:short)" output
>> formatting, which was adapted from for-each-ref.
>> ...
>
> Karthik, getting a fix in for "git tag" regression is more important
> than the topics parked in 'pu', so I'll queue this patch in the
> early part of 'pu'.
>
> I personally feel that "refname:strip=<n>" would be a good mechanism
> for end users to specify a custom format, and it is unclear to me
> what should happen when there are not enough elements to be
> stripped, so I do not think we want to cast the "we will show the
> whole thing" decision in stone prematurely only because we want to
> push out the regression fix soon.  So I may ask Jeff to rework this
> one (or I may end up trying to do so myself) not to squat on the
> nice strip=<n> notation.  refname:strip-standard-prefix that removes
> the known prefix ("refs/heads", "refs/remotes" and "refs/tags") if
> present and does not touch the refname otherwise would leave us more
> time to decide what strip=<n> should do in the error case.
>
> Unfortunately, this means kn/ref-filter-atom-parsing topic from you
> that were parked on 'pu' must be ejected for now, as any change in
> this area overlaps with it, and the atom parsing code would need to
> be updated to learn about the new attribute of the 'refname' atom
> (be it 'remove-prefix=<glob>', 'strip=<n>', or something else) that
> we would decide to use for the regression fix anyway.

That should be fine, there are still changes to be done there so I'll rebase
on this and send that series.

-- 
Regards,
Karthik Nayak
