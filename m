From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 4/4] fast-export: trivial cleanup
Date: Thu, 9 May 2013 03:53:13 -0500
Message-ID: <CAMP44s1DPwfiEDuUqUSBN1ShsgLDy9_2E0OD6nnwT7kJeJUCyg@mail.gmail.com>
References: <1368062218-22440-1-git-send-email-felipe.contreras@gmail.com>
	<1368062218-22440-5-git-send-email-felipe.contreras@gmail.com>
	<CAEBDL5VotNSZC_xHc3r49bBFtNwU+drWa_Pj=skC3xzk-CGpKA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
To: John Szakmeister <john@szakmeister.net>
X-From: git-owner@vger.kernel.org Thu May 09 10:53:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UaMbK-0006cp-01
	for gcvg-git-2@plane.gmane.org; Thu, 09 May 2013 10:53:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752765Ab3EIIxQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 May 2013 04:53:16 -0400
Received: from mail-lb0-f173.google.com ([209.85.217.173]:45663 "EHLO
	mail-lb0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752748Ab3EIIxO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 May 2013 04:53:14 -0400
Received: by mail-lb0-f173.google.com with SMTP id 10so280135lbf.18
        for <git@vger.kernel.org>; Thu, 09 May 2013 01:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=IHh8bNaKU2hyjvVidGfQXxdBXwyCNc6rtqJqcCpJWDI=;
        b=Ubk0yjlrctFSL5haE4RPn7UbFF9Zsh1mA+/WcRbh6Ajjbej2Z8UXu8McuZ5+FV7245
         kYYo9FxYJ1xIz2rifOX1yiZCdL8nhG7tNIByQgTg9/hOKIL0ga7FJavPsIfUka8WAr4N
         kDG5NyOuehkjn4e60ugE+1UlOP073wWx++n9MYgjB+8EzAk06E3ZIs7PcDZ7Mtxt9OxT
         FtR3s1MOwO/fhtA+r6U+1gsYT3V40oVourCzo11IJrsAHvVdsAKXYYURJQXcc3N+RwsI
         sIgZVLiwfAJKzi76Oa/lnishHVUyEuMbfSgZmLw8TvEXfI2x3XYALElIx0SYFEBCEgYP
         DC4A==
X-Received: by 10.112.166.101 with SMTP id zf5mr4890745lbb.59.1368089593153;
 Thu, 09 May 2013 01:53:13 -0700 (PDT)
Received: by 10.114.184.3 with HTTP; Thu, 9 May 2013 01:53:13 -0700 (PDT)
In-Reply-To: <CAEBDL5VotNSZC_xHc3r49bBFtNwU+drWa_Pj=skC3xzk-CGpKA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223718>

On Thu, May 9, 2013 at 3:52 AM, John Szakmeister <john@szakmeister.net> wrote:
> On Wed, May 8, 2013 at 9:16 PM, Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
>> Cast the object to a commit, only to get the object back?
>>
>> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
>> ---
>>  builtin/fast-export.c | 5 +----
>>  1 file changed, 1 insertion(+), 4 deletions(-)
>>
>> diff --git a/builtin/fast-export.c b/builtin/fast-export.c
>> index 8091354..d24b4d9 100644
>> --- a/builtin/fast-export.c
>> +++ b/builtin/fast-export.c
>> @@ -550,7 +550,6 @@ static void get_tags_and_duplicates(struct rev_cmdline_info *info,
>>
>>  static void handle_tags_and_duplicates(struct string_list *extra_refs)
>>  {
>> -       struct commit *commit;
>>         int i;
>>
>>         for (i = extra_refs->nr - 1; i >= 0; i--) {
>> @@ -562,9 +561,7 @@ static void handle_tags_and_duplicates(struct string_list *extra_refs)
>>                         break;
>>                 case OBJ_COMMIT:
>>                         /* create refs pointing to already seen commits */
>> -                       commit = (struct commit *)object;
>> -                       printf("reset %s\nfrom :%d\n\n", name,
>> -                              get_object_mark(&commit->object));
>> +                       printf("reset %s\nfrom :%d\n\n", name, get_object_mark(object));
>
> FWIW, this line is now too long (exceeds 80 columns).  Good catch on
> the casting though.
>
> -John
>
> PS  Sorry for the duplicate Felipe... I still need to get used to
> hitting "Reply All". :-)

The guideline is:

 - We try to keep to at most 80 characters per line.

The key word being *try*.

-- 
Felipe Contreras
