From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH/RFC 01/10] ref-filter: introduce a parsing function for
 each atom in valid_atom
Date: Sat, 12 Dec 2015 21:35:19 +0530
Message-ID: <CAOLa=ZQKQE-iyNY2gyZXMxPANHzJr0GoDJVuts3qb-izDKVVsQ@mail.gmail.com>
References: <1447271075-15364-1-git-send-email-Karthik.188@gmail.com>
 <1447271075-15364-2-git-send-email-Karthik.188@gmail.com> <CAPig+cRYEmbsye78ESOLfmSi56sBFeKpaEkpGSEwF=qrLZWx8g@mail.gmail.com>
 <CAOLa=ZTFeKMMSRCTWi9RkSvuCh7ZecPudSgsJB4TV76U4aGJJA@mail.gmail.com>
 <CAPig+cRcxr7uT2OJX=TnaVf+gXQdw9ydp+7X+Kis4Vb5+6RHiA@mail.gmail.com>
 <CAOLa=ZTHaety8=cxP4PqcXqrRv9OAEAcRyTs9drY6nSFGKvyOQ@mail.gmail.com> <xmqqio44eijo.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Dec 12 17:05:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a7mgD-0008I8-RD
	for gcvg-git-2@plane.gmane.org; Sat, 12 Dec 2015 17:05:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751517AbbLLQFu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Dec 2015 11:05:50 -0500
Received: from mail-vk0-f43.google.com ([209.85.213.43]:35313 "EHLO
	mail-vk0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751032AbbLLQFt (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Dec 2015 11:05:49 -0500
Received: by vkha189 with SMTP id a189so132402956vkh.2
        for <git@vger.kernel.org>; Sat, 12 Dec 2015 08:05:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=DgXRJRJErW4pEGxmDtEaTRZ5R39CQcQl+GBereNFuAg=;
        b=PCwHMUNd8PSaXImqo0AsIxgOAy/vPn39Ap16nPWO4RDV9NbiXcURzd5xb8E2j3S1sA
         YOzTV8d+Ishley0MBeBJurtc7YmM0/3xc83F5B477Fcfg9wobZNUHL9CBxk89JVGwGXg
         pcRYEl9u3PEkScQZciBRnZtarLC78upJv4fv91scnIajI99OpoUioI1y6nEUz6+sHkF6
         gHjlxgN6B+RRdYM9+STrG5xpVUPS6+03dNfIDvoe4MiDWz1MyiD3vWFdBMI6/46+MNwz
         pRYQM/Q50QagJzNzgh1b3X7vQoMn+bcuTecjmmUHKPdH9UqU07+mg58ni2hMWk6cNI50
         405w==
X-Received: by 10.31.142.206 with SMTP id q197mr18229129vkd.95.1449936348619;
 Sat, 12 Dec 2015 08:05:48 -0800 (PST)
Received: by 10.103.97.199 with HTTP; Sat, 12 Dec 2015 08:05:19 -0800 (PST)
In-Reply-To: <xmqqio44eijo.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282303>

On Sat, Dec 12, 2015 at 3:48 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
>>> This problem will go away if you introduce the 'valid_atom' field in
>>> the patch which actually needs it (as suggested above) rather than in
>>> this patch.
>>
>> Yup, agreed.
>> Thanks for your suggestions.
>
> In addition, most of the lines in this patch should become
> unnecessary even after you start using the "parser" field.
>
> As the majority of fields are compared as strings, and only a
> selected few fields need custom parsers, you do not have to
> explicitly write FIELD_STR everywhere, as long as you make sure the
> value of FIELD_STR is zero (and use parser==NULL as a sign that no
> custom parser is used, which I think you already do).

True, currently I've changed it to only add the new parser function values
only wherever required.

-- 
Regards,
Karthik Nayak
