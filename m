From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [WIP/PATCH v4 6/8] for-each-ref: rename some functions and make
 them public
Date: Sun, 31 May 2015 16:03:11 +0200
Message-ID: <CAP8UFD117bJotFQSGjGnSub_0Xq=3wH2o3Du4c49xvmMxAyFDQ@mail.gmail.com>
References: <5569EF77.4010300@gmail.com>
	<1433008411-8550-6-git-send-email-karthik.188@gmail.com>
	<CAP8UFD080Yuv-CYcDzAG0u6OV7Sqry=0s1HKoJbt5wfKjTNO3Q@mail.gmail.com>
	<CAP8UFD1TTMfruCE-+GT-LzhK5C9LorStPbn64tZ-hhAkC=8Bdw@mail.gmail.com>
	<556AD1B2.3080502@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 31 16:03:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yz3pe-0001kR-BK
	for gcvg-git-2@plane.gmane.org; Sun, 31 May 2015 16:03:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758331AbbEaODO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 May 2015 10:03:14 -0400
Received: from mail-wi0-f175.google.com ([209.85.212.175]:33742 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753707AbbEaODM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 May 2015 10:03:12 -0400
Received: by wicmx19 with SMTP id mx19so50114539wic.0
        for <git@vger.kernel.org>; Sun, 31 May 2015 07:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=hN5eWQrBWUocOQu1DqSSeFc1KH9sN+s4j/iBxu4P6TU=;
        b=xHYUgqhhKR89ifYKh2OoWCY9DRnhrnf/kJ3mqJPy6BI7jV73vbfuIxElI4nCdonvom
         POh0f3gbcVErt89dK+SO8oIzTiby5JPnC4LVVRg0vjbNBm9o8fSDyAXp02tv7V6HncKZ
         ThJWG64e3nUEjHlvIHQq8msldkLglD2+ZWLwGaw1wglnHeojdPwtHAsxv2kthm7iIns7
         rsjhHx5gE2RnCZ8woaCaUD9g9Vcyz8G/FBHt/zdXCiGn8NYTmNPAGeHnmh7A2cvwNQoo
         GDX5buifOuMwBOHI/MhBXWil0NK5l/ZQKVx5ufYXZfrYD0IYow8nMOHRmWKiEYJQ66Of
         Dx5g==
X-Received: by 10.181.13.198 with SMTP id fa6mr12555098wid.41.1433080991241;
 Sun, 31 May 2015 07:03:11 -0700 (PDT)
Received: by 10.194.40.8 with HTTP; Sun, 31 May 2015 07:03:11 -0700 (PDT)
In-Reply-To: <556AD1B2.3080502@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270331>

On Sun, May 31, 2015 at 11:17 AM, Karthik Nayak <karthik.188@gmail.com> wrote:
> On 05/31/2015 01:41 PM, Christian Couder wrote:
>>
>> On Sun, May 31, 2015 at 10:04 AM, Christian Couder
>> <christian.couder@gmail.com> wrote:
>>>
>>> On Sat, May 30, 2015 at 7:53 PM, Karthik Nayak <karthik.188@gmail.com>
>>> wrote:
>>>>
>>>>
>>>> -static void sort_refs(struct ref_sort *sort, struct ref_array *array)
>>>> +void sort_ref_array(struct ref_sort *sort, struct ref_array *array)
>>>
>>>
>>> It is probably better to call the above function ref_array_sort()...
>>>
>>> [...]
>>>
>>>> -static struct ref_sort *default_sort(void)
>>>> +/*  If no sorting option is given, use refname to sort as default */
>>>> +struct ref_sort *ref_default_sort(void)
>>>
>>>
>>> ... especially since you call the above ref_default_sort()...
>>>
>>>> -static int opt_parse_sort(const struct option *opt, const char *arg,
>>>> int unset)
>>>> +int opt_parse_ref_sort(const struct option *opt, const char *arg, int
>>>> unset)
>>>
>>>
>>> ... and the above opt_parse_sort().
>>
>>
>> After saying that I realize that these two other functions are not
>> doing the same thing.
>> This might suggest that they are not named very well as well.
>>
>
> What do you mean by "not doing the same thing."

sort_ref_array() is actually sorting a ref_array, while
ref_default_sort() and opt_parse_ref_sort() are not sorting anything.

Maybe it would all be clearer with a renaming like the following:

sort_refs() -> ref_array_sort()
struct ref_sort -> struct ref_sort_criteria
default_sort() -> ref_default_sort_criteria()
opt_parse_sort() -> opt_parse_ref_sort_criteria()
