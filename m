Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D52DFBF6
	for <git@vger.kernel.org>; Sun,  2 Mar 2025 02:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740882478; cv=none; b=gE8W3pi/g0HGZzvcdcfC4M314jcU4JQwV5q+1jK6HXqpQD11D+q77I9jUMVdd9b7xG6p7Qo/JOI87b5EKn58X9LGbIU21rCKn4Ehp8ynMMmvAHP0d16lEiMhf/a7kkc7j8OR7Hsz8vAYYZ9qRrkGRpQtd3imM0R7yIZ3D7K2HBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740882478; c=relaxed/simple;
	bh=oB/Xl84CpH+JxXpeBeN3HHGWbqmCPLNfgzhLYD76Z4c=;
	h=From:Message-ID:Date:MIME-Version:To:Subject:Content-Type; b=nCiyw0U5mt7gprsfPctpf+bKFog0/PiGQeB0BgJURBGdFxaD7JRkhoQlhkZ9z2gggWIE8z4lbPj1w1CYkHT7CaPMTKWgGD/6yZJD8jw5jEHMnD66B+bNKQIgq9fBhOf213gxa0DUL2HNToakaFSW+CGmMpLmPtAUrCjtfRqbPzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BvWPxTxB; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BvWPxTxB"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-47220d28138so48713161cf.3
        for <git@vger.kernel.org>; Sat, 01 Mar 2025 18:27:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740882475; x=1741487275; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:to:content-language:reply-to
         :user-agent:mime-version:date:message-id:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bTRvjrqL34ccaCHMrMEgf0eo4mEp3uQCEHrlIqSuQ4c=;
        b=BvWPxTxB+0vwVaPw4kuf4HpTBtAcK/ONfWNWJAMhzu9fxQZid/uwOo4+COdkOZP4hq
         gIcwLwavaSHR5HEygVMBjdl9M743SEOkuUypWE1m0sJceDqqAOoY7pXC5uN3V3/UVoCo
         uAMCsXJLSf4K9FsICtTCoPUU7IjWnte2NrrIZri0hYE6J5687PcEpJziqD7bfVGoFutl
         1zoJF/Y1i32cVLGHaAa0Q7Uk+5ihSAwQekVZYZ58v2gXYXCHUX3LXZ9U7qbYkIQZxoY7
         vrB0iJ3IqatdOep2OaMh2jqbot71PsAioUZYa0b/0BVbUfwWdS77JPDsikwPT+yqbd68
         TGsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740882475; x=1741487275;
        h=content-transfer-encoding:subject:to:content-language:reply-to
         :user-agent:mime-version:date:message-id:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bTRvjrqL34ccaCHMrMEgf0eo4mEp3uQCEHrlIqSuQ4c=;
        b=JDYc+V2aaVbGkiqxw49eZoyN5X/3y+0mxJl05AhePNBuXAAg5bgdx3gqmHgrYHH9Y8
         NkfY4Fq7RZC1YCkwXEO8n17BOCNJ03NQEx+jzuJUEZgnGgSDO7enMG56qx+8hZOzdygK
         10R0Rfb7eoKKvp67b1InR+axW7Sny/RcHgjz3WIxCW7QoJTmwj8ul8K52g9lKF19GBz6
         K7IKxOwyKFs3gVjFnQE01OmB/VvbXXEfzadpTSV7PrvYcCa69Q7Bp/W5TFILYCoYB1MU
         4FQuYxLTVRCIuc7c7CGMsfDh6H+zHhiFglRvIGqEAPxBNp7s0dowzVEXTWb8gkU7rah1
         cmtA==
X-Gm-Message-State: AOJu0Yzo779IoeqGgiz5QfJe7pDD7psXdQ2RThp80Nm4eftd1epFh5/5
	WhI4guS8abz2hbYqlvgGbxCoefO2GnvHBQh5uiJ8ZPHnchEtFtE7S2gUKg==
X-Gm-Gg: ASbGnctgZeGuPvWijS+hEL6k7fb3CbB+A4lXPKVyCDmxuET0JHSiCucGKbYnYFxm6nB
	ZoZQntcNnEE8BYNuC6sqsdG/FWntJj9KnqaOHjGuPRprPtduy+4iK8f9GVrElSK6oG3/NbZnbXP
	V1nyKKSkFjVvOPx87YqoFGUP3J/NcBcV3mFl4L2CUTANK/GK+bYqdn0SabcaTSihVpakGzYFyyY
	RB4Q0lAxC/OE+LrSMvaFt4LJ5R99QA6/dmBJ7H27v06LpN8ETXjasO1k5IlpD5dlu+8PSUKwkFF
	1vIh6JPEdziH1hO08Jk+idHGRmVyEUSyNv3TuWvxGLPJlB0JfFgLZ+vQV6yJvqAwTCMuzn+iDBP
	Ww2QhQBocKCajUWS4UMXggQ==
X-Google-Smtp-Source: AGHT+IFy+pzn5Rrhc0JDKfhA9yT9XyH9/mIAU7H3pSZfjbbs1VnPxiCbsZ2gbzigE+7xA6BpG+Hwug==
X-Received: by 2002:a05:622a:118b:b0:471:f8a6:6cf2 with SMTP id d75a77b69052e-474bc06a76amr136878101cf.16.1740882474614;
        Sat, 01 Mar 2025 18:27:54 -0800 (PST)
Received: from [192.168.1.174] (c-73-143-206-114.hsd1.ma.comcast.net. [73.143.206.114])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4746b4f9507sm43173211cf.27.2025.03.01.18.27.53
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Mar 2025 18:27:54 -0800 (PST)
From: Nikolay Shustov <nikolay.shustov@gmail.com>
X-Google-Original-From: Nikolay Shustov <Nikolay.Shustov@gmail.com>
Message-ID: <e3e8729b-2f0f-43d4-bd3b-422302df9fa1@gmail.com>
Date: Sat, 1 Mar 2025 21:27:52 -0500
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: Nikolay.Shustov@gmail.com
Content-Language: en-US
To: git@vger.kernel.org
Subject: git-p4 enhancements and fixes
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello,
I am having in works the following changes to git-p4 which I found 
useful for the usage workflow I typically have to follow.
I think these could be useful for the users of git-p4 in general.
Looking for the feedback and comments.
Thank you in advance for your time and consideration.

Enhancements:
=============

New git-p4.P4CommandErrorEncoding (string) configuration setting
****************************************************************

This configuration setting allows to specify the characters encoding 
that will be used for reading the errors Perforce commands may return. 
If not set, utf-8 is used.
This setting is useful when Perforce client and/or server are configured 
to use single-byte encoding, like Laitn-1; in such cases git-p4 errors 
out while trying to decode error messages from Perforce commands which 
happen to contain high-bit set characters in the output.
Setting git-p4.P4CommandErrorEncoding to ‘latin-1’ will now allow git-p4 
to proceed.

New --disable-p4refresh command line option
*******************************************

If used, git-p4 will not attempt to sync the associated p4 workspace 
before creating changelist from git commits.
New associated configuration setting: git-p4.disableP4Refresh (boolean)

New --new-changelist command line option
****************************************

Can be used for “shelve” command git-p4 command.
If used, git-p4 will create a new numbered changelist from gits commits, 
as opposite to using default changelist.
New associated configuration setting: git-p4.makeNewChangelist (boolean)

New --keep-p4opened command line option
***************************************

Can be used for “shelve” git-p4 command.
If used, git-p4 will not revert the changelist files after creating 
shelving them.
New associated configuration setting: git-p4.keepShelvedFilesOpened 
(boolean)

New --p4-description-file=<filepath> command line option
********************************************************

This option used instructs git-p4 will use the given file contents as a 
template for the description of new changelist.
The template supports the following substitutions:
     {message} – substituted with the commit message
     {hash}  – substituted with the commit hash
New associated configuration setting: git-p4.descriptionTemplateFile 
(string)

Example: --p4-description-file=~/git-p4/default-description.txt


New --p4-description=string command line option
***********************************************

This option used instructs git-p4 will use the given string as a 
template for changelist message.
The template supports the following substitutions:
     {message} – substituted with the commit message
     {hash}  – substituted with the commit hash
     \n – substituted with the newline character; allows to create 
multiline descriptions.
New associated configuration setting: git-p4.descriptionTemplate (string)

Example: --p4-description=”{message}\nGit commit: {hash}”

New --no-edit-p4spec command line option
****************************************

If used, git-p4 will not bring up editor for editing the changelist spec 
before proceeding, for the usage scenarios where it normally would.
Associated with the existing configuration setting git-p4.skipSubmitEdit

New --edit-p4spec command line option
*************************************

If used, git-p4 will bring up editor for editing the changelist spec 
before proceeding, for the usage scenarios where it normally would not.


Fixes:
======

Issue: After p4 revert operations, git-p4 leaves writeable files in the 
Perforce workspace.

Scenario: git-p4 reverts created changelist, as a result of the 
successful shelve or after error happened.

Problem: The files that were added, are left in the Perforce workspace 
abandoned and writeable after the revert operation. Now these files are 
in the way of the syncing the Perforce workspace unless it is explicitly 
instructed to clobber writeable files and/or forced sync is used 
(depending on workspace settings etc.)

Fix: For such scenarios, git-p4 implementation now calls “p4 revert” 
with “-w” option, which instructs Perforce client to delete files which 
were marked in changelist as “added”.
-------------------------------------------------------------------------------------------------------------------------------------------------

Thank you,
- Nikolay
