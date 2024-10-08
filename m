Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 815CA1E00B1
	for <git@vger.kernel.org>; Tue,  8 Oct 2024 16:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728403977; cv=none; b=islj5o5d4K6oqqMU1l5ooqGtxKICklf4oIj1NZ/cdQLmG1yod7lz8zHBlt99DBX71hwxqNgiJjLyJW7EUa+7IXCilRsOJKfXn5BsZyhYp2eN6UC9mWvn2/yt/nZcuMs45xdAs6bXrrQBQ/92BI4prjcr759XIlLD9+kCj758JwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728403977; c=relaxed/simple;
	bh=9+tacaX5o+jWO79MGKBwIFg3y7hC969LrTzhXSG3+QY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q8RO+vgu0gLAqTHRTfmNFWP8WXui3LUDmuYqXZkVT+CWBFRGIrIJ4AoO44Oaz2qbpwKbceXNEeK4K6HVvwmZR9IhSldtdxu8qfJOubRs6locFfVguwuD9ocsk7VVEHYUKOIXZ6ZbzAZ403oo2OB9PhXkYJVXAoPbNFtpZ56Ud0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O+qC5Lp9; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O+qC5Lp9"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a83562f9be9so634890666b.0
        for <git@vger.kernel.org>; Tue, 08 Oct 2024 09:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728403974; x=1729008774; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VNspmtgfVcCWSek5fgbD8wH5mSt8m//vaOr4lswjvV0=;
        b=O+qC5Lp9ne9oZ4ckHZAl+5Qd09+HYyGOEJtueMIUQLRYs8py+62kP9no378mS0Tl+8
         jf/ooCB0IqG8nr4xKRruvETGbQFn7gAhBeGQKkC9+vO2hIYw9zoW8Yflhsuu5pbPKS6G
         SYj/51q3hGhRCclNkhi0ojRSRg8VPa3N2wa/Iz264WqL0iq0kSITS094sz3fRFwjBGzf
         oLFikkq+89U1vboSlklCV3CBdf0OPIgVDlHywKrPCN4RX/9MZYzxd5xwobF8oa6DeJJv
         VvR6USEDNgVcTa3UxQs7OdpcJ69sqNRWh4wCP6QxEBwBxOJ3poV9iH8DIbHt1LLj7nHa
         Dfxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728403974; x=1729008774;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VNspmtgfVcCWSek5fgbD8wH5mSt8m//vaOr4lswjvV0=;
        b=FOCR5wM/0vjOqT0fbLx/Sc0TppHhwEIKIL4bOhaBOvDg7Uf8iOmT8UVge4Y2XrVeEU
         /zKE42Uhi9uxYlEEbfMx2Kndbv7XeEt1solOtIOoMt7mG0jUfQpdVLhettdqfoPeF00K
         0ODWAFtc2BrclcBpTRWBFkO6+SfbaN0G+6xJqag1zcQl2R2gAnku1A2THGvpi0Q8+QqT
         aypeeRi0Fx4zshfPhSfX5/3LIGtbtoYHuAyiRWPiPYian/+W2EHAo8qMPRfv+It0zjae
         7gbcUHCGhl5zsSrKrnxZQPF/xlptA6jVwZL3jdtW6VJULcWUk1SuR4WeN7/RfGSr+0+P
         tMZg==
X-Gm-Message-State: AOJu0Yzhg+EpUKvBxWWHax6ZvRAjv14r7cGZRQteDgJI14ieNE41X1F1
	x3skGq9uTu2ATLBYqy6xr8kGZIsWYCo32Z2IePoC2MO3lEiBeyv1Wye4RMLrE+2S06a3l9myKry
	Hoy+ylHZxy7BlBleeuUT2QY11MZZ/Lshr6IG2CA==
X-Google-Smtp-Source: AGHT+IFDf1zonVhzNUM6UqZ4xilqdJIL3XXtgpOHiJDE9JfAcJsCqm0cDbwHlDN2sffQ2MaTsByrfjUi7X1kv7MQVbs=
X-Received: by 2002:a17:907:9490:b0:a99:63d8:a1bd with SMTP id
 a640c23a62f3a-a9963d8a2c9mr360580166b.16.1728403973569; Tue, 08 Oct 2024
 09:12:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1809.git.1728370892696.gitgitgadget@gmail.com>
 <pull.1809.v2.git.1728397437637.gitgitgadget@gmail.com> <CAAirc3j2MfLyiNVnseRmTsDDu6R4gkcms1GXk=9_jAVLvEYaUg@mail.gmail.com>
 <CAAirc3gX=PBixcyR0NRyRDnrydkeeu8A9or90c8MSUdHQ6uo=w@mail.gmail.com>
In-Reply-To: <CAAirc3gX=PBixcyR0NRyRDnrydkeeu8A9or90c8MSUdHQ6uo=w@mail.gmail.com>
From: Abhijeetsingh Meena <abhijeetsingh.github@gmail.com>
Date: Tue, 8 Oct 2024 21:42:42 +0530
Message-ID: <CAAirc3jxEV9ZrLcZRMNahZTXWV-1H3KwGXT2iEU+nsZWX2bUnA@mail.gmail.com>
Subject: Re: [PREVIEW v2] blame: respect .git-blame-ignore-revs automatically
To: Abhijeetsingh Meena via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Kristoffer Haugsbakk <code@khaugsbakk.name>, 
	Phillip Wood <phillip.wood123@gmail.com>, Abhijeetsingh Meena <abhijeet040403@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kristoffer,

Thank you so much for your feedback and for taking the time to review
my patch. I appreciate your suggestions, particularly regarding the
project convention of using the present tense to describe the current
behavior, as well as your mention of the --no-ignore-revs-file option
and the importance of documenting it.

Regarding your first point:

> My assumption then is that, with this change, I could use --no-ignore-rev=
s-file to turn off the default file.

I=E2=80=99ll check how this works in the current setup and get back to you =
to confirm.

As for your second observation:

> git blame --ignore-revs-file=3DREADME.md
> --no-ignore-revs-file README.md
> And that works without giving errors. So it=E2=80=99s there. Just apparen=
tly undocumented?

I=E2=80=99ll look into opening an issue and submitting a PR to add
documentation for this, as it seems important to address.

I=E2=80=99m excited to refine the patch with these improvements in mind and
will continue working on the commit message and necessary
documentation in line with your feedback.

Thanks again for your guidance and support!

Best regards,
Abhijeet (Ethan0456)

On Tue, Oct 8, 2024 at 8:53=E2=80=AFPM Abhijeetsingh Meena
<abhijeetsingh.github@gmail.com> wrote:
>
> Hi Phillip,
>
> Thank you for your feedback on my patch. I appreciate your insights regar=
ding the decision not to support a default file for the --ignore-revs-file =
feature and the concerns related to ignoring "cleanup" commits that could p=
otentially introduce bugs.
>
> I understand that addressing these concerns is crucial. Specifically, I w=
ill focus on:
>
> 1. Ensuring there=E2=80=99s a clear and easy way for users to opt out or =
override the default behavior of ignoring certain commits, especially if th=
ey suspect those commits might contain bugs.
> 2. Investigating how this new feature could interact with existing config=
uration options that allow users to specify what should be ignored manually=
.
>
> I will take these points into consideration as I work on my changes and c=
ome up with a solution to address these concerns.
>
> Thank you again for your guidance, and I look forward to your continued f=
eedback!
>
> Best wishes,
> Abhijeet (Ethan0456)
>
> On Tue, Oct 8, 2024 at 8:53=E2=80=AFPM Abhijeetsingh Meena <abhijeetsingh=
.github@gmail.com> wrote:
>>
>> Hi Kristoffer,
>>
>> Thank you so much for your feedback and for taking the time to review my=
 patch. I appreciate your suggestions, particularly regarding the project c=
onvention of using the present tense to describe the current behavior, as w=
ell as your mention of the --no-ignore-revs-file option and the importance =
of documenting it.
>>
>> Regarding your first point:
>>
>> > My assumption then is that, with this change, I could use --no-ignore-=
revs-file to turn off the default file.
>>
>> I=E2=80=99ll check how this works in the current setup and get back to y=
ou to confirm.
>>
>> As for your second observation:
>>
>> > git blame --ignore-revs-file=3DREADME.md
>> > --no-ignore-revs-file README.md
>> > And that works without giving errors. So it=E2=80=99s there. Just appa=
rently undocumented?
>>
>> I=E2=80=99ll look into opening an issue and submitting a PR to add docum=
entation for this, as it seems important to address.
>>
>> I=E2=80=99m excited to refine the patch with these improvements in mind =
and will continue working on the commit message and necessary documentation=
 in line with your feedback.
>>
>> Thanks again for your guidance and support!
>>
>> Best regards,
>> Abhijeet (Ethan0456)
>>
>> On Tue, Oct 8, 2024 at 7:54=E2=80=AFPM Abhijeetsingh Meena via GitGitGad=
get <gitgitgadget@gmail.com> wrote:
>>>
>>> From: Abhijeetsingh Meena <abhijeet040403@gmail.com>
>>>
>>> Modify `git blame` to automatically respect a `.git-blame-ignore-revs`
>>> file if it exists in the repository. This file is used by many projects
>>> to ignore non-functional changes, such as reformatting or large-scale
>>> refactoring, when generating blame information.
>>>
>>> Before this change, users had to manually specify the file with the
>>> `--ignore-revs-file` option. This update streamlines the process by
>>> automatically detecting the `.git-blame-ignore-revs` file, reducing
>>> manual effort.
>>>
>>> This change aligns with the standardized practice in many repositories
>>> and simplifies the workflow for users.
>>>
>>> Signed-off-by: Abhijeetsingh Meena <abhijeet040403@gmail.com>
>>> ---
>>>     blame: respect .git-blame-ignore-revs automatically
>>>
>>>
>>>     Introduction
>>>     =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>>
>>>     Hi, I'm Abhijeet (Ethan0456), and this is my first contribution to =
the
>>>     Git project. I currently work as an ML Engineer at an early-stage
>>>     startup, and I=E2=80=99m excited to contribute to this open-source =
project.
>>>
>>>
>>>     Why the Change?
>>>     =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>>
>>>     I came across this enhancement request on the bug tracker and found=
 it
>>>     beginner-friendly, making it a great opportunity for me to get fami=
liar
>>>     with the Git codebase. The ability for git blame to automatically
>>>     respect the .git-blame-ignore-revs file is something that can strea=
mline
>>>     workflows for many users, and I felt it would be a valuable additio=
n.
>>>
>>>
>>>     Feedback
>>>     =3D=3D=3D=3D=3D=3D=3D=3D
>>>
>>>     While I=E2=80=99m confident in the changes made to builtin/blame.c =
and the new
>>>     test case in t/t8015-blame-ignore-revs.sh, I welcome any feedback o=
r
>>>     suggestions to improve both my code and approach. I=E2=80=99m eager=
 to learn
>>>     from the community and improve where needed.
>>>
>>>
>>>     Community Need
>>>     =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>>
>>>     There is precedent for this functionality in other projects:
>>>
>>>      * Chromium
>>>        [https://chromium.googlesource.com/chromium/src.git/+/f0596779e5=
7f46fccb115a0fd65f0305894e3031/.git-blame-ignore-revs],
>>>        which powers many popular browsers, uses .git-blame-ignore-revs =
to
>>>        simplify the blame process by ignoring non-functional changes.
>>>      * Rob Allen's blog post
>>>        [https://akrabat.com/ignoring-revisions-with-git-blame/] discuss=
es
>>>        the need for ignoring revisions with git blame, and a commenter
>>>        specifically suggests that it would be helpful if Git automatica=
lly
>>>        respected .git-blame-ignore-revs.
>>>
>>>     I hope this change aligns with community needs and improves the git
>>>     blame experience for users.
>>>
>>> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1809%=
2FEthan0456%2Fblame-auto-ignore-revs-v2
>>> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1809/Eth=
an0456/blame-auto-ignore-revs-v2
>>> Pull-Request: https://github.com/gitgitgadget/git/pull/1809
>>>
>>> Range-diff vs v1:
>>>
>>>  1:  666404681d9 =3D 1:  666404681d9 blame: respect .git-blame-ignore-r=
evs automatically
>>>
>>>
>>>  builtin/blame.c                      |  8 ++++++++
>>>  t/t8015-blame-default-ignore-revs.sh | 26 ++++++++++++++++++++++++++
>>>  2 files changed, 34 insertions(+)
>>>  create mode 100755 t/t8015-blame-default-ignore-revs.sh
>>>
>>> diff --git a/builtin/blame.c b/builtin/blame.c
>>> index e407a22da3b..1eddabaf60f 100644
>>> --- a/builtin/blame.c
>>> +++ b/builtin/blame.c
>>> @@ -1105,6 +1105,14 @@ parse_done:
>>>                 add_pending_object(&revs, &head_commit->object, "HEAD")=
;
>>>         }
>>>
>>> +       /*
>>> +       * By default, add .git-blame-ignore-revs to the list of files
>>> +       * containing revisions to ignore if it exists.
>>> +       */
>>> +       if (access(".git-blame-ignore-revs", F_OK) =3D=3D 0) {
>>> +               string_list_append(&ignore_revs_file_list, ".git-blame-=
ignore-revs");
>>> +       }
>>> +
>>>         init_scoreboard(&sb);
>>>         sb.revs =3D &revs;
>>>         sb.contents_from =3D contents_from;
>>> diff --git a/t/t8015-blame-default-ignore-revs.sh b/t/t8015-blame-defau=
lt-ignore-revs.sh
>>> new file mode 100755
>>> index 00000000000..84e1a9e87e6
>>> --- /dev/null
>>> +++ b/t/t8015-blame-default-ignore-revs.sh
>>> @@ -0,0 +1,26 @@
>>> +#!/bin/sh
>>> +
>>> +test_description=3D'default revisions to ignore when blaming'
>>> +
>>> +TEST_PASSES_SANITIZE_LEAK=3Dtrue
>>> +. ./test-lib.sh
>>> +
>>> +test_expect_success 'blame: default-ignore-revs-file' '
>>> +    test_commit first-commit hello.txt hello &&
>>> +
>>> +    echo world >>hello.txt &&
>>> +    test_commit second-commit hello.txt &&
>>> +
>>> +    sed "1s/hello/hi/" <hello.txt > hello.txt.tmp &&
>>> +    mv hello.txt.tmp hello.txt &&
>>> +    test_commit third-commit hello.txt &&
>>> +
>>> +    git rev-parse HEAD >ignored-file &&
>>> +    git blame --ignore-revs-file=3Dignored-file hello.txt >expect &&
>>> +    git rev-parse HEAD >.git-blame-ignore-revs &&
>>> +    git blame hello.txt >actual &&
>>> +
>>> +    test_cmp expect actual
>>> +'
>>> +
>>> +test_done
>>> \ No newline at end of file
>>>
>>> base-commit: 777489f9e09c8d0dd6b12f9d90de6376330577a2
>>> --
>>> gitgitgadget
