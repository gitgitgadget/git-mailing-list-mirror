From: karthik nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v3 3/3] cat-file: add "--literally" option
Date: Mon, 09 Mar 2015 18:23:29 +0530
Message-ID: <54FD97C9.40909@gmail.com>
References: <54F89D90.6090505@gmail.com>	<1425579578-18955-1-git-send-email-karthik.188@gmail.com> <CAPig+cTWJcWuhbgbaHWYcFxXhCEN-ou3g=AP6k1KJ-+hgN_+Dg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Mon Mar 09 13:53:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YUxBo-0005eJ-8A
	for gcvg-git-2@plane.gmane.org; Mon, 09 Mar 2015 13:53:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752119AbbCIMxe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Mar 2015 08:53:34 -0400
Received: from mail-pd0-f176.google.com ([209.85.192.176]:40141 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751438AbbCIMxd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Mar 2015 08:53:33 -0400
Received: by pdbfp1 with SMTP id fp1so57590776pdb.7
        for <git@vger.kernel.org>; Mon, 09 Mar 2015 05:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=1iJAYlU4kSzrfrEnxeZTxvO+081GmMOSPSebk42aAmA=;
        b=zSlSdlsMkK4nisRt9OOMVHnE8r4dFgmhvwqLAjNQR3md0oYfOBNWjADBOGciaJNDVP
         julNeJrNcHwHhcZhk6JelNzXFPX1jA+AWO5Pe14FmcoIR4GCTpXu8JWRqg8vkY6uRaE1
         30VGEVzXlyL8eGhHUpu2Jp30KQrpocROip+qNpdSjIyQUkHQp07oyWrpprCjTxO1PSaU
         ZeZkJ7XQzNVbg2Af5f3vQjYWEnRyfNM2d9ApnZiP0xaf7m2eVyiOdhVmD2f97rtNHwuK
         U2DH7VIANV5HHFKgCen5VVlli1Af73GNn7bni01O5S29HYfOQwhF5fmkasNAKn3jvapu
         lWfw==
X-Received: by 10.66.62.137 with SMTP id y9mr53729071par.87.1425905613100;
        Mon, 09 Mar 2015 05:53:33 -0700 (PDT)
Received: from [192.168.0.102] ([103.227.98.178])
        by mx.google.com with ESMTPSA id k5sm19101270pdf.95.2015.03.09.05.53.30
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Mar 2015 05:53:31 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
In-Reply-To: <CAPig+cTWJcWuhbgbaHWYcFxXhCEN-ou3g=AP6k1KJ-+hgN_+Dg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265162>



On 03/09/2015 04:20 AM, Eric Sunshine wrote:
> On Thu, Mar 5, 2015 at 1:19 PM, Karthik Nayak <karthik.188@gmail.com> wrote:
>> made changes to "cat-file" to include a "--literally"
>
> Write in imperative mood: "Teach cat-file a --literally option..."
>
>> option which prints the type of the object without any
>> complaints.
>
> Unfortunately, this explanation is quite lacking. What "complaints"?
> What problem is --literally trying to solve? To answer these
> questions, you will probably want to say something about the sort of
> object which requires --literally, and how cat-file fails or behaves
> without it.
>
>> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
>> ---
>> diff --git a/builtin/cat-file.c b/builtin/cat-file.c
>> index df99df4..60b9ec4 100644
>> --- a/builtin/cat-file.c
>> +++ b/builtin/cat-file.c
>> @@ -323,7 +332,7 @@ static int batch_objects(struct batch_options *opt)
>>   }
>>
>>   static const char * const cat_file_usage[] = {
>> -       N_("git cat-file (-t | -s | -e | -p | <type> | --textconv) <object>"),
>> +       N_("git cat-file (-t|-s|-e|-p|<type>|--textconv|-t --literally) <object>"),
>
> This might read more naturally as:
>
>      git cat-file (-t [--literally] | -s | -e | -p | <type> |
> --textconv) <object>
>
> rather than repeating the -t option.
>
>>          N_("git cat-file (--batch | --batch-check) < <list-of-objects>"),
>>          NULL
>>   };
>> @@ -369,6 +379,8 @@ int cmd_cat_file(int argc, const char **argv, const char *prefix)
>>                  OPT_SET_INT('p', NULL, &opt, N_("pretty-print object's content"), 'p'),
>>                  OPT_SET_INT(0, "textconv", &opt,
>>                              N_("for blob objects, run textconv on object's content"), 'c'),
>> +               OPT_BOOL( 0, "literally", &literally,
>> +                         N_("show the type of the given loose object, use for debugging")),
>
> Taking other help strings into account, there is no need for the
> long-winded "type of the given loose object" when "loose object's
> type" will suffice. More importantly, thought, you should try to say
> something about how --literally is actually useful, such as for
> "broken" objects or objects not of a known type.
>
>>                  { OPTION_CALLBACK, 0, "batch", &batch, "format",
>>                          N_("show info and content of objects fed from the standard input"),
>>                          PARSE_OPT_OPTARG, batch_option_callback },
>> @@ -380,7 +392,7 @@ int cmd_cat_file(int argc, const char **argv, const char *prefix)
>>
>>          git_config(git_cat_file_config, NULL);
>>
>> -       if (argc != 3 && argc != 2)
>> +       if (argc != 3 && argc != 2 && argc != 4)
>
> Perhaps it's time to rephrase this as "if (argc < 2 || argc > 4)"?
>
>>                  usage_with_options(cat_file_usage, options);
>>
>>          argc = parse_options(argc, argv, prefix, options, cat_file_usage, 0);
>> @@ -405,5 +417,10 @@ int cmd_cat_file(int argc, const char **argv, const char *prefix)
>>          if (batch.enabled)
>>                  return batch_objects(&batch);
>>
>> -       return cat_one_file(opt, exp_type, obj_name);
>> +       if (literally && opt == 't')
>> +               return cat_one_file(opt, exp_type, obj_name, literally);
>> +       else if (literally)
>> +               usage_with_options(cat_file_usage, options);
>
> I realize that existing cases in cat-file are already guilty of this
> transgression, but it is quite annoying when a program merely spits
> out its usage statement without actually telling you what you did
> wrong; and it's often difficult to figure out why it was rejected. It
> would be much more helpful in a case like this to state explicitly
> that --literally was given without -t. (But perhaps such a
> "friendliness" change is fodder for a separate patch.)
>
>> +
>> +       return cat_one_file(opt, exp_type, obj_name, literally);
>>   }
>> --
>> 2.3.1.167.g7f4ba4b.dirty

Thanks for the feedback.
Will fix everything you stated in the next patch.
