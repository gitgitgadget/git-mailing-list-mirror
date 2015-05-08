From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 3/3] git help: group common commands by theme
Date: Fri, 8 May 2015 17:19:43 -0400
Message-ID: <CAPig+cS5OmsEz-_DRZqA_5G9p1ODA1qV4cMhmJWBtPFAMqDbrw@mail.gmail.com>
References: <cover.1430770308.git.sebastien.guimmara@gmail.com>
	<13c3dcbd2c5c9dfc0453381b5da53b5d68af7afe.1430770308.git.sebastien.guimmara@gmail.com>
	<CAPig+cS=u-HK1qNicWiLOQC6RPkR7QueX+kOu8fQwpHekgs1yg@mail.gmail.com>
	<554D25B1.8050605@gmail.com>
	<CAGZ79kaL219wN4=c9_SQGDk+Mtie0Xm5PDc0Jy6mTQiQ37wj4A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?Q?S=C3=A9bastien_Guimmara?= <sebastien.guimmara@gmail.com>,
	Git List <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri May 08 23:19:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YqpgS-000578-SX
	for gcvg-git-2@plane.gmane.org; Fri, 08 May 2015 23:19:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752874AbbEHVTo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 8 May 2015 17:19:44 -0400
Received: from mail-ie0-f182.google.com ([209.85.223.182]:36192 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752391AbbEHVTo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 8 May 2015 17:19:44 -0400
Received: by iecnq11 with SMTP id nq11so73470302iec.3
        for <git@vger.kernel.org>; Fri, 08 May 2015 14:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=BRjfpSUSJtzhjbX4jfh6Nn5A+ii5YRkWKpMWSu54WP4=;
        b=iu9tY9VjlPs2MZn6X3BFg3xiSo4VTl0hP/6a5byRj7Ed15k4J3sELicaN2tzieb4NK
         5sNHJTNhvk1xFQaWZYqmPEnCh4pJ7dsXjtpZKXpZUJ8f4sit/NvDNV5LrgwAh5buuqSv
         qrZ9aMYWDw5UEr6+r2C47QlA0rtz9tWOR02aDnQ9bvhXwbHyRcABe8dF6Nyw1vunQB2m
         p3YWSgF7cA8EJFHUBXcCCZbbi9fwH9tSeiBejvrIFWtRWL/Mijpr3I8Vxjb7ta/SprEE
         LDgmeC8QAGKg4fyIBZIDnqOLaszTqT4+oUXrqg0xE11anSWcNP7mnU3aPfyKs4qRmKIH
         Kgjg==
X-Received: by 10.50.66.230 with SMTP id i6mr183568igt.22.1431119983581; Fri,
 08 May 2015 14:19:43 -0700 (PDT)
Received: by 10.107.28.132 with HTTP; Fri, 8 May 2015 14:19:43 -0700 (PDT)
In-Reply-To: <CAGZ79kaL219wN4=c9_SQGDk+Mtie0Xm5PDc0Jy6mTQiQ37wj4A@mail.gmail.com>
X-Google-Sender-Auth: 5vQ4ifI3TjcVM_5iFsr852l4aJI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268672>

On Fri, May 8, 2015 at 5:17 PM, Stefan Beller <sbeller@google.com> wrot=
e:
> On Fri, May 8, 2015 at 2:08 PM, S=C3=A9bastien Guimmara
> <sebastien.guimmara@gmail.com> wrote:
>> On 05/06/2015 05:16 AM, Eric Sunshine wrote:
>>> Do you also want to sort the commands alphabetically within group?
>>> That is, something like this?
>>>
>>>      struct cmdname_help *e1 =3D elem1;
>>>      struct cmdname_help *e2 =3D elem2;
>>>
>>>      if (e1->group < e2->group)
>>>          return -1;
>>>      if (e1->group > e2->group)
>>>          return 1;
>>>      return strcmp(e1->name, e2->name);
>>>
>>>> +}
>>
>> Your version raises:
>>
>> help.c:223:28: warning: initialization discards =E2=80=98const=E2=80=
=99 qualifier from
>> pointer target type [enabled by default]
>>   struct cmdname_help *e1 =3D elem1;
>>                             ^
>> With the cast:
>> struct cmdname_help *e1 =3D (struct cmdname_help*)elem1;
>> It compiles without a warning (gcc (Ubuntu 4.8.2-19ubuntu1) 4.8.2)
>
> I'd rather change the type of struct cmdname_help to be const, such
> that it reads:
>
>       const struct cmdname_help *e1 =3D elem1;
>       const struct cmdname_help *e2 =3D elem2;
>
>       if (e1->group < e2->group)
>           return -1;
>       if (e1->group > e2->group)
>           return 1;
>       return strcmp(e1->name, e2->name);
>
> instead of casting if possible.

Right. That was just a quickly typed example in the email. The "real"
code should use a 'const' pointer.
