Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58FE347D479
	for <git@vger.kernel.org>; Wed, 29 Jul 2026 12:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785327827; cv=none; b=mnenRZd4hMBnUM2Y4uD99gxXKxmSM6As94YNNohkcVn+XPhz8fnsQec7rgjxDP+qy02hRwtxrAO8ZfPyt5KpyhvG8cwH034VA6JxVJyOpoBqcpxU5rtk/vpvyqWEGSYLFOiJmF/F5FqW7y4CcvqmW2efjxKLERgr6PMwsDjhzSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785327827; c=relaxed/simple;
	bh=LPcxZDRFizpP49qu2M7uiVOnfElfKqMaZgEFvMt5aZM=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=QY4AE3WlMxydI+WTGamL3fVad6pYuHxXYOYyFHdhLpsQRSGM5lFLtGkLJAi2IraEiKtbiYAZl3TSWAw7vcjJgfULgLuLSDCn6UBcsLD0eiJwBn7qddQY2fuwws6GjYdMyfRHWzC898HnJA1I1gw7GaPv7EiEBNADNAsGlGdXN7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FXkXXQtI; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FXkXXQtI"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-47f703a9d05so630167f8f.0
        for <git@vger.kernel.org>; Wed, 29 Jul 2026 05:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785327823; x=1785932623; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=3XzakVGwS193KYDJ+F7/hHFK/L6ntY4o+Exbl2PRzV4=;
        b=FXkXXQtIXB1JBzd6cwSi6RlRMX84c+L8qjo78Ck36GxsysM5yNIYvLGdeHODs2f4aa
         HSnItgvtHQjZORHVjKPdJwknRWjc74UrYS7wD7eq4cObwYasJiVj+RJSA1A+GrESOON/
         q75o5cgNdBkGUSlCjty0wsNR8HkoEw6/v5ddbBI73HDsn/eEM5b14Wjp3d3MWP9iRJXc
         kbG6+3pRmzFy/s9qgG8ZwaYscuUoNlnyauDtFF+SgpMmHzCTQwUVmLI312HFFTaYtDb/
         VqP0qeEg3CfV7dEX6ums5s8XaiFT3qYW9+PKIVnpiLE1q8h4xRnQXkanbBe2Bu5pSs/c
         aXGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785327823; x=1785932623;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3XzakVGwS193KYDJ+F7/hHFK/L6ntY4o+Exbl2PRzV4=;
        b=pr9C8XJFVYBN+hI2RStd/p7hUa/Fcpl+Hw7qVN3hKDp5ja0DDP9Ukdbk8iLOfe/O51
         yW4BhCAnBrNoctcHJDm9j3wO3gIcv0BOsW5LCbFvqIdOm7TJBIOV1yH6Dw4vLNl7oyhN
         7Cy0BoWTAWqp+iXjBtSf05wYgn8NO2RvUy1Icblz6VFqRlNGnDWpYjX++uG9PjbiXylc
         4B1iioAZuuTWi8qR6tykOGBPtXGYYZ68YC7MTA2fR+Gbk9VoujyCE6ORJiyZLo0oWH2O
         ioezuNKF3k3QFmvXCaaBvI8FISve2pABMeITGIcQFo12HnjG/8JYhTvmWxaI8ygi7Vzx
         DgbA==
X-Gm-Message-State: AOJu0YyN3kaTZ0dfIavAKkcsKrri5e8/w0c1+e56GhyxyfS3mBx2FoGT
	fk1MbZRIXM50R/St3ejEzUiUam0XCJooORqL5mJEWS8vyQIkztobaUH3
X-Gm-Gg: AR+sD10pras/ZJeGtHhBYNc7BA0QVQulYX7Xg3Z1nwaNeBcBf+LtqQRhdhVVKZtuwsb
	qrHdZp5+6yuF9HanVKRBySv7ORDWSxO2C6l2XRTzrSOsaSkFuN2QByGdLxMHLN4XOA4u0q3VnI+
	mhdm+M2tAHa7H1tBs3/JQjv8/l7eacxAylASe7kIHkFVsQ+/7RKCvRHjEKuZXvozaB9C/5dX29O
	UuLSBLC+Rqz97rz5doIyGMyjhVWijJTzFrel3gcE+BSrSdNxdKJ7qpkehPO+kf1q5aAdFN6VzZ6
	3y7OA52uMFY6wmxelBxCa+zH/zYRJO9Oo1C2LhX7QNf2C+BXnsOsb6UlltIk4+7aNr6GxqoGo7G
	TICf1C1s38Fn3gCU+HfaxH5H8docqc5iuT8Dm7vkJofdaolZwpXZT7lq8+I5flZ7aDcWSx2I7Ll
	n498eoqqcBTffz6q1WToN5ootIkwzPN+q+0LVtE98GrwO8pRpzsekDJRHpxm/FKmNzL/b9GNKPb
	SIh694Rd9igQdcVZISf/qnFyiF/hFhrLZyu+09AKc/5kLF+ta66KzrhjLUsFLeWH3lGg/U4rABS
	2R94QzAoQJd8TYVbJmbFBEI+mX1kv4UGIRzP7wRN1LDMdFlWAmJg2Wipq7Zr1QefYx+APBTa0Kc
	=
X-Received: by 2002:a5d:64c9:0:b0:475:f0f0:9ec8 with SMTP id ffacd0b85a97d-47fb1ec0a4dmr7969297f8f.51.1785327823164;
        Wed, 29 Jul 2026 05:23:43 -0700 (PDT)
Received: from localhost ([47.58.8.78])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fb6b0ef1asm7805947f8f.19.2026.07.29.05.23.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jul 2026 05:23:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 29 Jul 2026 14:23:41 +0200
Message-Id: <DKB1W6RATEE8.SZDO9CJ5V8WT@gmail.com>
Cc: <git@vger.kernel.org>, <karthik.188@gmail.com>, <gitster@pobox.com>
Subject: Re: [PATCH GSoC 5/5] cat-file: unify default format
From: "Pablo Sabater" <pabloosabaterr@gmail.com>
To: "Chandra Pratap" <chandrapratap3519@gmail.com>, "Pablo Sabater"
 <pabloosabaterr@gmail.com>
X-Mailer: aerc 0.21.0
References: <20260725-objecttype-support-v1-0-2d4ca3bbabf1@gmail.com>
 <20260725-objecttype-support-v1-5-2d4ca3bbabf1@gmail.com>
 <CA+J6zkQAAkeM67+yJGLG7z9+TV0sJ2cZp-dV+xCJn2c4V9wVJQ@mail.gmail.com>
In-Reply-To: <CA+J6zkQAAkeM67+yJGLG7z9+TV0sJ2cZp-dV+xCJn2c4V9wVJQ@mail.gmail.com>

On Wed Jul 29, 2026 at 11:59 AM CEST, Chandra Pratap wrote:
> On Sat, 25 Jul 2026 at 17:25, Pablo Sabater <pabloosabaterr@gmail.com> wr=
ote:
>>
>> %(objecttype) is supported both by the client and by the server.
>> Change the temporary default format to the unified version that other
>> commands use.
>
> s/other/the other

Will fix thanks.

>
>> Update documentation to remove %(objecttype) from the caveats of
>> remote-object-info.
>>
>> Update tests that used the default format to expect type.
>
> Not super accurate. We're updating the tests to expect the new default
> format.

I will reword it to something like:

Now that type is supported and the default format unified, update the
tests to expect the new default format.

>
>> Update documentation to show %(objecttype) support.
>>
>> Mentored-by: Karthik Nayak <karthik.188@gmail.com>
>> Mentored-by: Chandra Pratap <chandrapratap3519@gmail.com>
>> Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
>> ---
>>  Documentation/git-cat-file.adoc        | 17 ++++-----
>>  Documentation/gitprotocol-v2.adoc      | 15 ++++++--
>>  builtin/cat-file.c                     |  7 ----
>>  t/t1017-cat-file-remote-object-info.sh | 70 ++++++++++++---------------=
-------
>>  4 files changed, 42 insertions(+), 67 deletions(-)
>>
>> diff --git a/Documentation/git-cat-file.adoc b/Documentation/git-cat-fil=
e.adoc
>> index ac3b528c6f..514bfc0032 100644
>> --- a/Documentation/git-cat-file.adoc
>> +++ b/Documentation/git-cat-file.adoc
>> @@ -348,15 +348,12 @@ newline. The available atoms are:
>>         after that first run of whitespace (i.e., the "rest" of the
>>         line) are output in place of the `%(rest)` atom.
>>
>> -The command `remote-object-info` only supports the `%(objectname)` and
>> -`%(objectsize)` placeholders. See `CAVEATS` below for more information.
>> +The command `remote-object-info` only supports the `%(objectname)`,
>> +`%(objectsize)` and `%(objecttype)` placeholders. See `CAVEATS` below f=
or more
>> +information.
>>
>>  If no format is specified, the default format is `%(objectname)
>> -%(objecttype) %(objectsize)`, except for `remote-object-info` commands =
which
>> -use `%(objectname) %(objectsize)` because `%(objecttype)` is not suppor=
ted yet.
>> -
>> -WARNING: When "%(objecttype)" is supported, the default format WILL be =
unified,
>> -so DO NOT RELY on the current default format to stay the same!!!
>> +%(objecttype) %(objectsize)`.
>>
>>  If `--batch` is specified, or if `--batch-command` is used with the `co=
ntents`
>>  command, the object information is followed by the object contents (con=
sisting
>> @@ -453,9 +450,9 @@ scripting purposes.
>>  CAVEATS
>>  -------
>>
>> -Note that only `%(objectname)` and `%(objectsize)` are currently
>> -supported by the `remote-object-info` command. Using any other placehol=
der in
>> -the format string will return an empty string in its position.
>> +Note that only `%(objectname)`, `%(objectsize)` and `%(objecttype)` are
>> +currently supported by the `remote-object-info` command. Using any othe=
r
>> +placeholder in the format string will return an empty string in its pos=
ition.
>>
>>  Note that the sizes of objects on disk are reported accurately, but car=
e
>>  should be taken in drawing conclusions about which refs or objects are
>> diff --git a/Documentation/gitprotocol-v2.adoc b/Documentation/gitprotoc=
ol-v2.adoc
>> index 7bf62014c3..de4bfb776e 100644
>> --- a/Documentation/gitprotocol-v2.adoc
>> +++ b/Documentation/gitprotocol-v2.adoc
>> @@ -558,14 +558,17 @@ object-info
>>
>>  `object-info` is the command to retrieve information about one or more =
objects.
>>  Its main purpose is to allow a client to make decisions based on this
>> -information without having to fully fetch objects. Object size is the o=
nly
>> -information that is currently supported.
>> +information without having to fully fetch objects. Object size and type=
 are the
>> +only information that is currently supported.
>
> s/is currently/are currently

Will fix.

>
>>  An `object-info` request takes the following arguments:
>>
>>         size
>>         Requests size information to be returned for each listed object =
id.
>>
>> +       type
>> +       Requests type information to be returned for each listed object =
id.
>> +
>>         oid <oid>
>>         Indicates to the server an object which the client wants to obta=
in
>>         information for. They must be full OIDs.
>> @@ -580,11 +583,15 @@ space.
>>         info =3D *PKT-LINE(attr LF)
>>                *PKT-LINE(obj-info LF)
>>
>> -       attr =3D "size"
>> +       attr =3D "size" | "type"
>>
>>         obj-size =3D 1*DIGIT
>>
>> -       obj-info =3D obj-id [SP [obj-size]]
>> +       obj-type =3D "blob" | "tree" | "commit" | "tag"
>> +
>> +       obj-val =3D obj-size | obj-type
>> +
>> +       obj-info =3D obj-id [SP [obj-val *(SP obj-val)]]
>>
>>  If the server does not recognize the OID, the response will be `<oid> S=
P`
>>  regardless of the number of attributes requested.
>> diff --git a/builtin/cat-file.c b/builtin/cat-file.c
>> index 884b6d5ad3..8288511b19 100644
>> --- a/builtin/cat-file.c
>> +++ b/builtin/cat-file.c
>> @@ -841,15 +841,9 @@ static void parse_cmd_remote_object_info(struct bat=
ch_options *opt,
>>         struct object_info *remote_object_info =3D NULL;
>>         struct oid_array object_info_oids =3D OID_ARRAY_INIT;
>>         struct string_list object_info_options =3D STRING_LIST_INIT_NODU=
P;
>> -       const char *saved_format =3D opt->format;
>>
>>         if (strlen(line) >=3D MAX_REMOTE_OBJ_INFO_LINE)
>>                 die(_("remote-object-info command too long"));
>> -       /*
>> -        * TODO: Use the default format once %(objecttype) is supported.
>> -        */
>> -       if (!opt->format)
>> -               opt->format =3D "%(objectname) %(objectsize)";
>>
>>         line_to_split =3D xstrdup(line);
>>         count =3D split_cmdline(line_to_split, &argv);
>> @@ -904,7 +898,6 @@ static void parse_cmd_remote_object_info(struct batc=
h_options *opt,
>>                 data->is_remote =3D 0;
>>         }
>>         data->skip_object_info =3D 0;
>> -       opt->format =3D saved_format;
>>
>>         for (size_t i =3D 0; i < object_info_oids.nr; i++)
>>                 free_object_info_contents(&remote_object_info[i]);
>> diff --git a/t/t1017-cat-file-remote-object-info.sh b/t/t1017-cat-file-r=
emote-object-info.sh
>> index 175f778cc9..741bdf34a0 100755
>> --- a/t/t1017-cat-file-remote-object-info.sh
>> +++ b/t/t1017-cat-file-remote-object-info.sh
>> @@ -139,10 +139,10 @@ test_expect_success 'batch-command remote-object-i=
nfo git:// default filter' '
>>                 set_transport_variables "$daemon_parent" &&
>>                 cd "$daemon_parent/daemon_client_empty" &&
>>
>> -               echo "$hello_oid $hello_size" >expect &&
>> -               echo "$tree_oid $tree_size" >>expect &&
>> -               echo "$commit_oid $commit_size" >>expect &&
>> -               echo "$tag_oid $tag_size" >>expect &&
>> +               echo "$hello_oid $hello_type $hello_size" >expect &&
>> +               echo "$tree_oid $tree_type $tree_size" >>expect &&
>> +               echo "$commit_oid $commit_type $commit_size" >>expect &&
>> +               echo "$tag_oid $tag_type $tag_size" >>expect &&
>>
>>                 git cat-file --batch-command >actual <<-EOF &&
>>                 remote-object-info "$GIT_DAEMON_URL/parent" $hello_oid $=
tree_oid
>> @@ -152,28 +152,6 @@ test_expect_success 'batch-command remote-object-in=
fo git:// default filter' '
>>         )
>>  '
>>
>> -test_expect_success 'remote-object-info does not change the default for=
mat of info' '
>> -       (
>> -               set_transport_variables "$daemon_parent" &&
>> -               cd "$daemon_parent/daemon_client_empty" &&
>> -
>> -               local_content=3D"local object" &&
>> -               local_oid=3D$(echo_without_newline "$local_content" | gi=
t hash-object -w --stdin) &&
>> -               local_size=3D$(strlen "$local_content") &&
>> -
>> -               echo "$local_oid blob $local_size" >expect &&
>> -               echo "$hello_oid $hello_size" >>expect &&
>> -               echo "$local_oid blob $local_size" >>expect &&
>> -
>> -               git cat-file --batch-command >actual <<-EOF &&
>> -               info $local_oid
>> -               remote-object-info "$GIT_DAEMON_URL/parent" $hello_oid
>> -               info $local_oid
>> -               EOF
>> -               test_cmp expect actual
>> -       )
>> -'
>> -
>
> I feel like deleting this test removes the only test in this file that va=
lidates
> calling info and remote-object-info in the same cat-file --batch-command
> session.
>
> Instead of deleting it, we should update it. Perhaps something like this:
>
> test "remote-object-info and info can be mixed using the unified
> default format":
>     // 1. Environment setup
>     // 2. Prepare a local object for the 'info' command
>     // 3. Construct the expected output. Since the default format is
> now unified,
>     // both commands should output exactly: <OID> <TYPE> <SIZE>
>     // 4. Execute the batch command
>     // 5. Validate

This test was because we were modifying the default format whenever
remote-object-info was used. The workaround to have them work together
was to store the previous format, save the format as the capped one for
remote-object-info and at the end restore it.

Now that it has been unified for both it is implicit that they can work
together. However, no harm in having a test explicitly proving it. I will
make what you suggest.

Thanks for the feedback,
Pablo

