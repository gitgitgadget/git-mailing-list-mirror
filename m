Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4225F4DCB05
	for <git@vger.kernel.org>; Mon, 19 Oct 2026 14:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792419904; cv=none; b=PABoNFYkXtqLaJfdny0yThzhJL4AL3NRACLeY+eKisT8gLuGW70yxQzGmKteFh2pBvYmi92nFDUY6fXMsCc4U4PpaEmGPIRUblTG5WP2m6/3Me5vyw+4TGt70f3S+Jsld1TmIcUr95MejcRbGzQ/iiJv3t53nHc+BfVsYLKjcNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792419904; c=relaxed/simple;
	bh=RpVNYe/L2QTNEveqUvVkQEEPL/ONq9lnujA30XYwdJM=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=A3HyuDyooWRM1114hUjFEq3MufRgsCYiWWOH4C7Ko+EPznqwIQ0O4Is/MwZb4xi9w1NApYV8KtWxcp3QvR7SuGBKULBtfUot2xT54KhXJ60sQm/2/oJi0QO0I/8SV7xnde+wWqBl0ozPJlII2isUPZ1s3oWLY5Wi2lJZAk4lscU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca; spf=pass smtp.mailfrom=jvns.ca; dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b=uNkvK7PK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=J3Qqyuob; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvns.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b="uNkvK7PK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="J3Qqyuob"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 7F6461D000FA
	for <git@vger.kernel.org>; Mon, 19 Oct 2026 10:25:00 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-05.internal (MEProxy); Mon, 19 Oct 2026 10:25:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvns.ca; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1792419900;
	 x=1792506300; bh=JK3caHloryKwBHNTRlICU3n8EcmRx8sGQg5LGQ1lvkI=; b=
	uNkvK7PKBrJUsM9l9aTgmmfkLhR5HrY6FukfB69j3HVq8IUJkwOqca/DQ/7DeBRY
	fvl9n59pFUKXROuibQ2iy40KOLfQrPk5z6ubcH3+1YOC7bEUPTSAN3SpvWjbk1RU
	1haZTCnDFU2TlMQ+F/lwtEOCpzzjAqZbOz3/94TEJz3rjQepze9mB8x/GaqcSwQ8
	3AN3Ht2BzRLztWthFweqtWHwmkycIARBbWu3Ia66/mq3pdyZxrB2F+qluY9sTImu
	lxHhImcZQxqkW0br2mvUSlr+/YChxXYu2juJZT6RwJQfhIFoh/o07UH8Wy8lmAsD
	6KaB71Z3U/XDPccV6yXWlA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1792419900; x=
	1792506300; bh=JK3caHloryKwBHNTRlICU3n8EcmRx8sGQg5LGQ1lvkI=; b=J
	3QqyuobIUpDepDu6dgNmRLSMvVvwROCVblbELCdMWpjTVxs0I82XvMqJbG+GMFr4
	VKT6kdMs7CuffXcU/deRejaNRRbbk8FyiL37Lf6ImKMt8lpE2fm6mNJ4bpIF6kdB
	pR09U0f8JtETvo8NZLAZ6U4cfvSUgojjPw1lK85EiXahqWwYxHy07sPHqm16378P
	ZF0GXahOYguAsE2CNsGuQRP/2ONltbhG7+mgMuRZqeeoIz2WPV6vTUfM99SeNem4
	NkKS/sT/yCpjmsBq8Hp8kg9Lxy0PLsJn5N+vfeXwGxmZvKgXu41MfOpd5sNR72qF
	m5O6FXRZp2IO4c9eF0XGg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=sign d=jvns.ca a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792419900; d=jvns.ca;
	mf=PGp1bGlhQGp2bnMuY2E+; rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:j2OPGREt8hZ+cSFEpbaVGofpDyp0CGFuL8YIQUlsHCZOljT
	QBauQxGUvk0pve9mk+6JUtdJRp+4XmDCj3JGtEvbBBgt8uWyox3NUTYlDgM5qRsC
	/gg4HQwKzLq1bg+x9FefuD78+omXV5/XwQyx7E/7L/quEb7QTEyWHRd9IyuDgZ9+
	wTUUUR0qqNNMT/nx3yMHA95OC36vj3kwDJiqpFrmHh23G2xlUxSt18FDKuGSoZ3+
	BEtTf65biX+Vyz+H/Ba+3LgBl38oexDmEQy1/6MfEn8Y1lXZKvCH75CoO8NztQS1
	S0g0gQEtZ/MCOx5h5sxZ3wofv6lk4s6PSgVhpFA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:7Z3JR3JoWbuXOxda7B/F0BAYGpVbedCpAYWqiDhEgv4=:RpVNYe/L2QTNEveqUvVkQEEPL/ONq9lnujA30XYwdJM=;
X-ME-Sender: <xms:OyjWaoiMpbUrkss43ryo_3VHQcriQEA8M4R89qbm8ShODBZjgFqEiA>
    <xme:OyjWar3ZrWxOXzdeC-1x1fFScmF3NnZGC75BIeE_qrKChz86GPQOpdIAXJtGakE7G
    zuDzKbM_564d9TmAjJFAj_MK7zftfetoDoiDEvr341NTbe38OMMENs8>
X-ME-Proxy-Cause: dmFkZTFVckwJHdPqCZBiIn8f0chE4jesHIF60cZFbKzY/2+N3D+a8YptaTVtLFWqjE+gTd
    Hm6sw4MVUz4jIgIb2921Qg6VUnTI1oaiuA0I15N1Tt2IvUhgGXVe2nnyBOmQR2M/QVdsgR
    FxRt+Z4o0xZ0kZC0MmeW9Z8K5Nkdf9eAbXZz2AdKKjH0f8EdGuf8gHEXEN+G7mIbUqhV4b
    gfjJ27jwLNCbM22gXp3kP7iUriw9dKILIWlV30qypgbxJU925L8d8trJM99JAzqKtaAiE2
    F8b0d5Oq9YmL8fXlfrmHos0oF77OcpVni2onXZCYsxzSf569KvX7ceiPsQEX448PuW3qmj
    PxrizffQx5l1kpG91bSzl7ant5CjH2G6Q+9LHHrYsD7KEXmlyuuqapsNC0DeWfWxq5CNER
    N3w+bJNxGbenXJ4jliz3iCqepOyNGSUkM4TbEm0v2u1X0zMkdZq4rxgX8kqGqlQRrU3gnY
    pMvySAgB73hxjLvOb6xVuPVaX8L7mLB8ThpY4A51zt9bJKKOu6fcuF2PyjwZJqLg1CY2X5
    3bbLAuxfVtBz2XeUGcgnm4Knw7CuIlbm5dMY38WqoONWhJl1Vui1ZlpXG4cYSdWBsiX9DG
    gXo5WOEs6t2Ou49COR5kidsKUnFKAs1W7XIrpKm2QY+cQMS4QN7sf5fpaoNQ
X-ME-Proxy: <xmx:OyjWap936RSz_VFxgKqAwozfpcN4h2v_wFhonXaV0H9JV-KN8yFTQw>
    <xmx:OyjWaldMP7qvX9pmcJUZG9DXwW2TVYza6No49ZXH8k3uE_0CT7Q_Nw>
    <xmx:OyjWaqEmH2j0LHP5OWKkKG-LT_sFZ_ctZiAGifU1ngSbmHrPkWLG0A>
    <xmx:OyjWareZ9ZZBvy2vrQ2GmcA7bH4vmRpiSqTbIpQSHC0Il6ZJadyTLg>
    <xmx:PCjWavf3rOOtkVOu3_gwtIkaAfcPd7D03MetRVOaRjVRFVfyCtzXzifq>
Feedback-ID: i2aa947c3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id DACB878273B; Mon, 19 Oct 2026 10:24:59 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: ApuIcoGem8Go
Date: Mon, 19 Oct 2026 10:24:39 -0400
From: "Julia Evans" <julia@jvns.ca>
To: "D. Ben Knoble" <ben.knoble@gmail.com>,
 "Julia Evans" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org
Message-Id: <3a38b208-2640-46a9-b486-9be614d71480@app.fastmail.com>
In-Reply-To: 
 <CALnO6CB0ApqKSfdmnekS7NKATJL4WrP4jpNBfryoOGKsFrz7+Q@mail.gmail.com>
References: <pull.2248.git.1791315422.gitgitgadget@gmail.com>
 <41dca2e8e0c5fadb8ad9ed8707029356e56cc540.1791315422.git.gitgitgadget@gmail.com>
 <CALnO6CB0ApqKSfdmnekS7NKATJL4WrP4jpNBfryoOGKsFrz7+Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] doc: add new Git tutorial for beginners
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On Wed, Oct 7, 2026, at 3:48 PM, D. Ben Knoble wrote:
> On Tue, Oct 6, 2026 at 3:37=E2=80=AFPM Julia Evans via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>>
>> From: Julia Evans <julia@jvns.ca>
>>
>> This tutorial covers:
>>
>> 1. Creating an empty repo with `git init`
>> 2. Making commits with `git add`, `git commit`, `git diff`, and
>>    `git status`
>> 3. Pushing to code to a Git host on the internet, including creating =
an
>>    SSH key
>>
>> Signed-off-by: Julia Evans <julia@jvns.ca>
>> ---
>>  Documentation/gittutorial.adoc | 616 +++++++++++++++++++++++++++++++=
++
>>  1 file changed, 616 insertions(+)
>>  create mode 100644 Documentation/gittutorial.adoc
>>
>> diff --git a/Documentation/gittutorial.adoc b/Documentation/gittutori=
al.adoc
>> new file mode 100644
>> index 0000000000..617dbae096
>> --- /dev/null
>> +++ b/Documentation/gittutorial.adoc
>> @@ -0,0 +1,616 @@
>> +gittutorial(7)
>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> +
>> +NAME
>> +----
>> +gittutorial - Introduction to Git for beginners
>> +
>> +DESCRIPTION
>> +-----------
>> +
>> +This tutorial explains how to import a project's code into Git, make
>> +changes to it, and upload the project to the Internet.
>> +
>> +We'll show you how to use the commands `git commit`, `git add`,
>> +`git diff`, `git status`, and `git push`.
>> +
>> +Command line vs GUI
>> +-------------------
>> +
>> +Git is a command line program, but there are many excellent GUIs for
>> +Git built by the community. For example, if you use an IDE to edit y=
our
>> +code, it might already have a built-in Git integration that you can =
use.
>> +
>> +In this tutorial, we'll give instructions for the command line versi=
on
>> +of Git, but you can also follow along in a GUI. You can also do some
>> +tasks in a GUI and some tasks on the command line. It's up to you.
>
> Since we assume a *nix-ish environment, should we mention that this
> tutorial works best on UNIX-like OSs, or in a Git-for-Windows Bash
> environment, and may need adapting for folks using PowerShell, CMD, or
> some other userspace (not a piece of jargon I would use here,
> probably)? Or does that get covered incidentally by the installation
> instructions?
>
> I'm especially thinking of not confusing a user who sees something
> different or doesn't have an "ls", "cd", etc. (Maybe my Windows
> command line knowledge is shoddy, though, and those parts just kind of
> work close enough for our purposes?)

Yes, great idea, this also inspired me to recruit more Windows testers.
Added a mention of Git Bash.

>> +
>> +What we'll be doing
>> +-------------------
>> +
>> +Git lets you take snapshots of your code, like a checkpoint in a vid=
eo
>> +game. In this tutorial we're going to explain a very basic Git
>> +workflow, which is:
>> +
>> +1. Create an empty folder
>> +2. Start using Git to manage the code in that folder
>> +3. Create 2 files and tell Git to save a snapshot of them
>> +4. Make changes to one of the files
>> +5. Tell Git to take another snapshot
>> +6. Repeat steps 4-5 any time you want to update your code
>
> I'm very tempted to nitpick "folder" vs "directory," but I'm not sure
> it's worth our time or that of the target audience :) Just note that,
> while "git grep folder" finds way more hits than I was expecting, it
> seems the primary use in our documentation is in reference to IMAP.

Yeah, I thought this might come up :) I don't have very strong feelings
here.

>> +We'll also explain how to use Git to put your code on the Internet.
>> +
>> +Step 1: Make sure Git is installed
>> +----------------------------------
>> +
>> +To do this tutorial, you'll need:
>> +
>> +1. Git to be installed. You might already have it installed,
>> +   and if not there are directions at https://git-scm.com/install/
>> +2. A folder on your computer with code that you want to start managi=
ng
>> +   with Git.
>> +
>> +You can check if Git is installed by running this in your terminal:
>> +
>> +------------------------------------------------
>> +$ git --version
>> +------------------------------------------------
>> +
>> +[[step_2]]
>> +Step 2: Introduce yourself to Git
>> +---------------------------------
>> +
>> +The first time you use Git on a computer, it's a good idea to tell G=
it
>> +your name and public email address. If you don't, you'll get a lot of
>> +warnings from Git. To do this, run:
>> +
>> +------------------------------------------------
>> +$ git config --global user.name "Namey McName"
>> +$ git config --global user.email you@example.com
>> +------------------------------------------------
>> +
>> +The name and email is so that other people you're collaborating with=
 can
>> +know who made the changes. You can set them to anything you want.
>> +
>> +To check if the name and email have been set, you can run these
>> +commands:
>> +
>> +------------------------------------------------
>> +$ git config user.name
>> +$ git config user.email
>> +------------------------------------------------
>
> Ought we recommend the newer forms (git config set, git config get)?
> Or is the idea to remain compatible with older versions, such as the
> 2.32 I happen to have in /usr/bin on unsupported macOS 12.7.6 from
> very old (?) XCode?
>
>> +
>> +Set your default branch name to `main`, by running this command.
>> +Git is going to change its default branch name to `main` soon, so th=
is
>> +sets you up well for the future.
>> +
>> +------------------------------------------------
>> +$ git config --global init.defaultBranch main
>> +------------------------------------------------
>> +
>> +If there's no output, then it succeeded.
>> +
>> +Step 3: Create an empty folder and 2 files
>> +------------------------------------------
>> +
>> +In your terminal, create an empty folder and change directories into=
 it.
>> +Later on you could follow the same steps in this tutorial to take an
>> +existing project and start managing it with Git, but we're going to =
use
>> +an empty project so that everyone following this tutorial has the ex=
act
>> +same files.
>> +
>> +For example, run these commands to make a folder called `myproject`
>> +
>> +------------------------------------------------
>> +$ mkdir myproject
>> +$ cd myproject
>> +------------------------------------------------
>
> I don't know, and I'll probably bias towards what you've already
> written over asking for changes, but: does it make things any easier
> to read and follow along with if we "git init myproject" instead?
> Perhaps this version plants the seed that it's not too late to start
> tracking any existing project, though, which is valuable :)
>
> I wonder if you had some rationale for choosing this particular
> sequence? Just curious, now.
>
>> +Create 2 files in this directory, so we have something to work with.
>> +
>> +Make a file called README.md, with these contents:
>> +
>> +------------------------------------------------
>> +We're doing a Git tutorial!
>> +We need 2 lines in this file so here's a second one
>> +------------------------------------------------
>> +
>> +And a file called `hello.py`, with these contents:
>> +
>> +------------------------------------------------
>> +print("hello world")
>> +------------------------------------------------
>> +
>> +Save the two files and keep them open in your text editor so you can
>> +easily edit them later. The exact contents aren't too important, but
>> +we'll use those contents in the example output later.
>> +
>> +You can check that the files are in the right place by running `ls`,
>> +like this:
>> +
>> +
>> +------------------------------------------------
>> +$ ls
>> +------------------------------------------------
>> +
>> +The output should be like this:
>> +
>> +------------------------------------------------
>> +hello.py
>> +README.md
>> +------------------------------------------------
>> +
>> +Step 4: Create a Git repository
>> +-------------------------------
>> +
>> +A Git repository is a folder which stores snapshots. It's usually a
>> +hidden folder called `.git`. Every time you take a snapshot, Git sto=
res
>> +a copy of the contents of every file you're tracking.
>> +
>> +This might feel unbelievable, but Git uses compression so you can ea=
sily
>> +store tens of thousands of snapshots without using too much disk spa=
ce.
>> +
>> +You can create a Git repository for any folder in your computer by
>> +running the command `git init`.
>> +
>> +Run `git init` in the folder you just created, like this:
>> +
>> +------------------------------------------------
>> +$ git init
>> +------------------------------------------------
>> +
>> +Git will reply:
>> +
>> +------------------------------------------------
>> +Initialized empty Git repository in .git/
>> +------------------------------------------------
>> +
>> +You might notice a new hidden folder was created, named `.git`.
>> +
>> +Step 5: Take your first snapshot
>> +--------------------------------
>> +
>> +Next, we're going to take a snapshot of all the files in the directo=
ry
>> +and tell Git to store them. Taking a snapshot in Git is a two step
>> +process: first you need to run `git add` and then `git commit`.
>> +
>> +The reason it's a two step process is that sometimes you might not
>> +actually want Git to store a snapshot of _all_ the files in a folder.
>> +For example, if you have a file full of private personal information
>> +called `personal.csv`, and a Python script called `process_data.py`,=
 you
>> +might want Git to keep a snapshot of the Python script but not the
>> +private data.
>> +
>> +For now, we're going to store a snapshot of every file in your folde=
r,
>> +as well as in every subfolder.
>> +
>> +The first step of creating a snapshot is to tell Git which files you
>> +want to include in the next snapshot using `git add`. To tell Git
>> +"include all files", run this command:
>> +
>> +------------------------------------------------
>> +$ git add .
>> +------------------------------------------------
>> +
>> +Next you can create the snapshot using the `git commit` command, like
>> +this. The `-m` flag stands for "message", and it lets you set a remi=
nder
>> +for your future self of what you were doing. The message ("Initial
>> +commit" in this example) can say anything you want.
>> +
>> +------------------------------------------------
>> +$ git commit -m "Initial commit"
>> +------------------------------------------------
>> +
>> +You've now stored the first version of your project in Git! From now=
 on
>> +we're going to use the word "commit" instead of "snapshot", since th=
at's
>> +the term Git uses.
>
> I know we want to limit scope=E2=80=A6 but I would love to not acciden=
tally
> encourage more use of "-m" for short (often useless?) messages.
> Unfortunately, that drags in the can of worms that is editor
> configuration. At least we can maybe point to
> https://git-scm.com/book/en/v2/Getting-Started-First-Time-Git-Setup#_e=
ditor
> and=20
> https://git-scm.com/book/en/v2/Appendix-C:-Git-Commands-Setup-and-Conf=
ig#ch_core_editor
> ? idk.

Definitely editor configuration is an issue. I haven't worked out where =
to
put this yet. I think it's very important to warn users that Git will pu=
t you
into `vim` by default, because I think a lot of new Git users will not be
comfortable with vim. Feels like a sticky situation and I still don't qu=
ite
know what advice to give people if they aren't comfortable with a
terminal text editor. I think the options are:

- only use `-m` and only write short messages
- use something like `nano`
- use a GUI interface to Git instead, which lets you write commit
messages in a more familiar interface

I don't think we should be prescriptive about commit message length
since the importance of this really depends on the context.

>> +Step 6: Make a change
>> +---------------------
>> +
>> +Now, let's learn how to make a change to a file and review the chang=
e you made.
>> +In this example, we'll update the file `README.md`, but you can edit=
 a
>> +different file.
>> +
>> +First open `README.md` in your favourite text editor, make a tiny or
>> +silly change, and save it.
>> +
>> +Next, in the terminal, run the command `git status` to get a summary=
 of
>> +what you changed since the last Git commit.
>> +
>> +------------------------------------------------
>> +$ git status
>> +------------------------------------------------
>> +
>> +The output will look something like this:
>> +
>> +------------------------------------------------
>> +On branch main
>> +
>> +Changes not staged for commit:
>> +  (use "git add <file>..." to update what will be committed)
>> +  (use "git restore <file>..." to discard changes in working directo=
ry)
>> +        modified:   README.md
>> +------------------------------------------------
>> +
>> +This output says that we've changed `README.md` since the last time
>> +we committed.
>> +
>> +Next, if you want to see the details of how you've changed `README.m=
d`,
>> +you can run `git diff`.
>> +
>> +------------------------------------------------
>> +$ git diff
>> +------------------------------------------------
>> +
>> +The output will look something like this:
>> +
>> +------------------------------------------------
>> +diff --git a/README.md b/README.md
>> +index 7ebaecb3..5a4ff712 100644
>> +--- a/README.md
>> ++++ b/README.md
>> +@@ -1,2 +1,2 @@
>> + Here are some Python scripts!
>> ++I hope you like them.
>> +------------------------------------------------
>> +
>> +This output says that we added one line, saying "I hope you like the=
m.".
>> +By default Git will show the lines you removed in red, and the lines=
 you
>> +added in green.
>
> I would perhaps prefer to focus on the leading sigils (-, +) than the
> color, if only because colorblindness can lead to all sorts of
> situations with different color setups in the terminal's palette or
> even (probably not our target audience) Git configuration. We could
> probably mention that Git shows added and removed lines in *different*
> colors without being too concerned with which colors those are? (That
> avoids having to twist our words like "your terminal palette's green
> and red" or w/e.)

Thanks, updated to mention the + and -.

>> +
>> +Step 7: Make another commit (easy way)
>> +--------------------------------------
>> +
>> +Now let's tell Git to save the new version of `README.md` by making
>> +another commit! To tell Git to snapshot all files that Git is tracki=
ng
>> +and commit them, run this command:
>> +
>> +------------------------------------------------
>> +$ git commit -am "Update README"
>> +------------------------------------------------
>> +
>> +This is similar to the two step process in Step 4 where we used `git
>> +add` and `git commit` to make a commit, but with a shortcut that lets
>> +you do both in just one command. The `-a` stands for "all".
>> +
>> +Step 7b: Make another commit (longer way)
>> +-----------------------------------------
>> +
>> +`git commit -am` is a fast way to snapshot all the files that Git is
>> +tracking. But if you want Git to ignore changes to certain files, you
>> +can instead do a 2-step process like in Step 4 where first you run `=
git
>> +add` for every file that's been changed and that you want to include=
 in
>> +the next commit, like this:
>> +
>> +------------------------------------------------
>> +$ git add README.md
>> +------------------------------------------------
>> +
>> +and then run `git commit` (without the `-a`), like this:
>> +
>> +------------------------------------------------
>> +$ git commit -m "Update README"
>> +------------------------------------------------
>> +
>> +Step 8: Make a change and throw it away
>> +---------------------------------------
>> +
>> +One of the most useful things about Git is that it lets you safely
>> +experiment: you never need to be scared to change your code because =
you
>> +can always go back to the old version.
>> +
>> +Before starting to experiment, run `git status` to check the current
>> +state of your Git repository:
>> +
>> +------------------------------------------------
>> +$ git status
>> +On branch main
>> +
>> +nothing to commit, working tree clean
>> +------------------------------------------------
>> +
>> +This "working tree clean" message means that there haven't been any
>> +changes since your last commit.
>> +
>> +Now make a change to your code, and run `git status` again. Like last
>> +time, you should see a message like this:
>> +
>> +------------------------------------------------
>> +$ git status
>> +On branch main
>> +
>> +Changes not staged for commit:
>> +  (use "git add <file>..." to update what will be committed)
>> +  (use "git restore <file>..." to discard changes in working directo=
ry)
>> +        modified:   README.md
>> +------------------------------------------------
>> +
>> +This tells us that `README.md` has been changed since the last commi=
t.
>> +But we don't actually want this change, so let's undo it! We can res=
tore
>> +`README.md` back to how it was at the most recent commit using the `=
git
>> +restore` command.
>> +
>> +**WARNING**: `git restore` can't be reversed! Any time you run it it=
's
>> +important to be absolutely sure that you're okay with throwing away =
your
>> +changes since the last commit.
>> +
>> +------------------------------------------------
>> +$ git restore README.md
>> +------------------------------------------------
>> +
>> +Now open `README.md` again. You should see that your changes have be=
en undone.
>> +
>> +You can stop here!
>> +------------------
>> +
>> +The commands we've learned so far (`git init`, `git add`, `git commi=
t`,
>> +`git diff`, `git status`, and `git restore`) are enough to get a lot=
 out
>> +of Git on their own.
>> +
>> +With these commands, you can keep copies of past versions of your co=
de
>> +on your computer and safely experiment with big changes to your code.
>> +
>> +When using Git this way, all of your code just lives on your compute=
r.
>> +But if you want to put your code on the Internet so that other people
>> +can use it or back it up, then you'll need to learn about one more
>> +command: `git push`.
>> +
>> +The rest of this tutorial is about how to upload your code to a Git
>> +repository on the Internet. The high level process is:
>> +
>> +1. Create an account on the Git host
>> +2. Configure Git so that it can login to the Git host to make changes
>> +3. Run `git push origin main` to upload your code
>> +
>> +Navigating the Git host's UI can be tricky, and it's hard for us to
>> +give you exact directions because the UIs change a lot.
>> +
>> +Step 9: Create an account on a Git host
>> +---------------------------------------
>> +
>> +To put your code on the Internet, you need it to be hosted somewhere.
>> +The easiest way to do this is to sign up with a Git host. There's a =
list
>> +of Git hosts (many of them offer free accounts) at
>> +https://git-scm.com/tools/hosting. GitHub and GitLab are two popular=
 hosts.
>> +
>> +If you're comfortable running a server, there are other ways to host
>> +a Git repository on the internet, like connecting through SSH or open
>> +source Git forge software to your server.
>> +
>> +Step 10: Create an SSH key (if needed)
>> +-------------------------------------
>> +
>> +For Git to upload changes to another Git repository, it needs a way =
to
>> +login to that repository. One of the most popular ways to do this is
>> +with an SSH key.
>> +
>> +If you don't already have an SSH key, you'll need to create one. On =
Mac
>> +or Linux, you can check if you already have an SSH key by running:
>> +
>> +-------------------------------------------
>> +$ ls ~/.ssh/*.pub
>> +-------------------------------------------
>> +
>> +If you don't already have an SSH key, run:
>> +
>> +-------------------------------------------
>> +$ ssh-keygen
>> +-------------------------------------------
>> +
>> +`ssh-keygen` will ask you for some details.
>> +The easiest way to do this is to just press Enter at every prompt un=
til
>> +it's done.
>> +
>> +NOTE: All of the advice about how to use SSH in this tutorial is aim=
ed
>> +at getting it to work as quickly as possible. Setting up SSH in a se=
cure
>> +way is very far outside the scope of this tutorial. If you have a
>> +security team in your organization, they might have very different
>> +opinions about the appropriate way to configure authentication with =
Git.
>> +
>> +Step 11: Tell the Git host your SSH public key
>> +----------------------------------------------
>> +
>> +First, find your SSH key like this (on Mac or Linux):
>> +
>> +-------------------------------------------
>> +$ ls ~/.ssh/*.pub
>> +-------------------------------------------
>> +
>> +That will output something like
>> +
>> +-------------------------------------------
>> +/home/alice/.ssh/id_ed25519.pub
>> +-------------------------------------------
>> +
>> +Copy the contents of that file to your clipboard. It's important that
>> +the filename ends in `.pub` ("pub" stands for "public").
>> +
>> +Then login to your account on the Git host you chose and paste the S=
SH
>> +key into the appropriate place. Depending on the Git host, it's like=
ly
>> +under "SSH keys" in your settings. If it asks you what type of SSH k=
ey,
>> +look for something like "Authentication Key".
>> +
>> +Once you've done this, you're done! Git will automatically use your =
SSH
>> +key to try to connect.
>> +
>> +Step 12: Create an empty Git repository on the Git host
>> +-------------------------------------------------------
>> +
>> +Go to the Git host's website and create a new Git repository.
>> +
>> +**WARNING**: If you create a public repository and push your reposit=
ory
>> +to it, then your name and email address, as well as the contents of
>> +any files you committed and every previous version of those files, w=
ill
>> +be on the public internet. Some Git hosts have the option to create
>> +a private repository instead, to keep your information private.
>> +
>> +Step 13: Find the address of the repository
>> +-------------------------------------------
>> +
>> +Now, find the address of the repository on your Git host. It should =
look
>> +something like this:
>> +
>> +-------------------------------------------
>> +git@git.example.com:username/repo.git
>> +-------------------------------------------
>> +
>> +(where `example.com`, `username` and `repo` will be replaced with the
>> +actual values).
>> +
>> +If you can only find an address starting with `https://`, then
>> +you can often translate it to the SSH format by replacing `https://`
>> +with `git@` and replacing the `/` after the domain name with an `:`.
>> +Here's how:
>> +
>> +-------------------------------------------
>> +https://git.example.com/username/repo
>> +^^^^^^^^               ^
>> +replace with "git@"    replace with ":"
>> +-------------------------------------------
>
> This is, of course, forge- and remote- dependent :) but I think it's
> *probably* ok for the tutorial.
>
> When you mentioned HTTPS-to-SSH translation, I was thinking of the
> config-based URL rewrite mechanism, aha! I definitely don't think we
> should go there ;)

Yeah, I thought about the config-based rewrites too and I don't think
we should mention it either :)

>> +
>> +Step 14: push your changes
>> +--------------------------
>> +
>> +Finally, we're ready to send the information in your local Git repos=
itory
>> +to the one on the internet!
>> +
>> +First, tell Git about the other repository by running `git remote ad=
d`
>> +in your terminal
>> +(replace `git@example.com:username/repo.git` with the actual address=
):
>> +
>> +-------------------------------------------
>> +$ git remote add origin git@example.com:username/repo.git
>> +-------------------------------------------
>> +
>> +This tells Git to save the URL `git@example.com:username/repo.git` in
>> +your Git repository's configuration under the name `origin`, so that=
 you
>> +can use it later. If you make a mistake while doing this, you can run
>> +`git remote remove origin` and try again.
>> +
>> +Then tell Git to send the information, with `git push`
>> +(if this doesn't work, read the "Troubleshooting `git push`" section=
 for advice!):
>> +
>> +-------------------------------------------
>> +$ git push -u origin main
>> +-------------------------------------------
>> +
>> +`origin` refers to the URL we just added (`git@example.com:username/=
repo.git`),
>> +and `main` is the name of your current Git branch. You can use any n=
ame
>> +(not just `origin`), but using `origin` often makes things easier
>> +because it's the default for `git push` and `git pull`.
>> +We haven't covered branches yet, but `main` is the default branch na=
me.
>
> I'm not sure if we should recommend "-u" without being able to explain
> what it does, and=E2=80=A6 well=E2=80=A6 you and I have discussed how =
that's difficult
> :)
>
> Doesn't the tutorial's recipe of always using "git push origin main"
> work just fine? And if we later introduce pull and other
> branch-/remote-stuff that cares about upstreams, we can mention this
> shorthand then?

Yeah, many people asked what `-u` stands for, we added an explanation.
TBD how well that explanation lands though.

>> +
>> +Any time you want to set up a new repository, you can repeat steps
>> +11-13, with one exception: you only need to pass `-u` the first time
>> +you push. Afterwards you can just run the command:
>> +
>> +-------------------------------------------
>> +$ git push origin main
>> +-------------------------------------------
>> +
>> +It should output something like this:
>> +
>> +-------------------------------------------
>> +To example.com:example_username/example
>> + * [new branch]        main -> main
>> +-------------------------------------------
>> +
>> +Troubleshooting `git push`
>> +--------------------------
>> +
>> +There are 3 main errors you might run into when running `git push or=
igin main`.
>> +Getting errors when running `git push` is actually a big part of usi=
ng
>> +Git, so congratulations! If you get to this part of the tutorial, you
>> +get a little bonus experience in debugging.
>> +
>> +Here's a guide to why they're happening and how to fix them.
>> +
>> +**Problem 1**: You pushed to `main`, but your branch actually isn't =
called `main`
>> +
>> +Here's the error:
>> +```
>> +$ git push origin main
>> +error: src refspec main does not match any
>> +```
>> +
>> +This might happen if you didn't set `init.defaultBranch` to `main` in
>> +<<step_2,Step 2>>.
>> +
>> +If you want to check the name of your current branch, you can run `g=
it
>> +status`. For example, in this output, the current branch is "master".
>> +
>> +-------------------------------------------
>> +$ git status
>> +On branch master
>> +
>> +...
>> +-------------------------------------------
>> +
>> +To push your branch, you have a few options:
>> +
>> +* rename your branch to `main`, by running `git branch -m main`
>> +  and then run `git push origin main`
>> +* run `git push origin master`
>> +  (where `master` is the name of your actual current branch)
>> +
>> +**Problem 2: SSH error**
>> +
>> +Here's the error:
>> +
>> +-----
>> +$ git push origin main
>> +The authenticity of host 'github.com (140.82.116.3)' can't be establ=
ished.
>> +ED25519 key fingerprint is: SHA256:+DiY3wvvV6TuJJhbpZisF/zLDA0zPMSvH=
dkr4UvCOqU
>> +This key is not known by any other names.
>> +Are you sure you want to continue connecting (yes/no/[fingerprint])?
>> +-----
>> +
>> +Git uses SSH to connect during `git push`, and this message happens =
when
>> +SSH connects to a new site that you haven't connected to before.
>> +
>> +The easiest way to handle this is to type "yes" and press Enter.
>> +
>> +**Problem 3: the repository already exists**
>> +
>> +Here's the error:
>> +
>> +---------------------
>> +$ git push origin main
>> +! [rejected]        main -> main (fetch first)
>> +error: failed to push some refs to 'example.com:example/example.git'
>> +hint: Updates were rejected because the remote contains work that yo=
u do not
>> +hint: have locally.
>> +---------------------
>> +
>> +If you see an error like this, it means that when you created the
>> +repository on your Git host, it created a repository with a file in =
it
>> +to try to help you out. (that's the "work that you do not have local=
ly"
>> +in the error message)
>> +
>> +You can fix this either by deleting the repository and recreating it=
, or
>> +by running:
>> +
>> +---------------------
>> +$ git push --force origin main
>> +---------------------
>> +
>> +**WARNING**: In general it's quite dangerous to use `--force` because
>> +it can erase work on the online repository in a way that's difficult=
 to
>> +recover. But if you know for sure that you just created the reposito=
ry 2
>> +minutes ago and there's nothing in it, then it's okay.
>> +
>> +MORE USEFUL GIT COMMANDS
>> +------------------------
>> +
>> +* To tell Git to "un-add" a file that you added by accident, run
>> +  `git rm --cached FILENAME`
>> +
>> +SEE ALSO
>> +--------
>> +linkgit:git-help[1],
>> +
>> +GIT
>> +---
>> +Part of the linkgit:git[1] suite
>> --
>> gitgitgadget
>
> Overall I think this is excellent (and I wish bottom-post replies
> encouraged saying this up front, hm).
>
> Thanks!

Thanks for the review!
