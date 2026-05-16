Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B3D3559CA
	for <git@vger.kernel.org>; Sat, 16 May 2026 15:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778945341; cv=none; b=OemY8dzirpHKiGF/deWFzCIMUvBcaQdYfANejRTISvzuL+3vDBdxr8gPNwP0HdtADaE1WciOYVWnyYZSUXQ4Sk6Al+bNX9dZyBpnlxMIK4kwxihtHl9NJldWXUFTdRXEsMBTm4Un5KVga2vYfdVDm/CYfxWCvC/7OWJ2tYjNNXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778945341; c=relaxed/simple;
	bh=nnGWo+5lhSDVqPNfhkNcANwa49B81VJ0zoJIvum4r90=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZoQIBEAfCdN/M//M6HZnLZFWZ+sc5YwlIWM42iPeEdLBD/gyhFDhEW6IN+oov30h/ONKZakGiwstyq7kUNfnV5RYhkz1zk+8Eni6MhQrIJJGK4j14hSwcEEll8aevGCRqpRk+WPtUIgO9BLr1bbGfFCecDkRKqqElXmFE8fkOas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ATb7t2V0; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ATb7t2V0"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-90d042fa745so194147385a.1
        for <git@vger.kernel.org>; Sat, 16 May 2026 08:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778945339; x=1779550139; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jNrU4RnF1uKSrPE2DS9d3jbJ9PudoA6Fl9e5uMc9diY=;
        b=ATb7t2V0DqA1/oOoJvhcstCAxXxu1KjmYouLQCgGO9/Db93e5vNmMBqQGulKpXwuhl
         fqnrPrNWfsTik3N00SOY42y9yF+4LBuukbWIli1lkfiyrx27hu5Wk5tEXIEaUO8H8bVu
         ICKv0P4YBMLbDr2IVxIs4GV6zJs5BBqKEt+hZDRrUjqPioTG9nyHsDcaglrfy88EU9gv
         QnfR5zH1umtI4mvOPnGhgq8r/fn7ED2MpKvo3uSg0fswT0wDN8wXO8XFi/sCYIc4lMsw
         dNMLR6CbmK2AbAOq08mLauXtf6SPlyYXzDh15oPK99XyMknstA/JptvJPa12mu1BPE3o
         +FwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778945339; x=1779550139;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jNrU4RnF1uKSrPE2DS9d3jbJ9PudoA6Fl9e5uMc9diY=;
        b=iyrrR1oegWJKR91nXxzS398ucq0UnDYpHBpW/kBwY9V6XR1GwmRcuz3/8IioES0KZi
         w5lBZyaRTcO79WMKaVvDj5Wi6rFDdbRYMkKatyXsFXNclchFMLRdVYXm7ef8q8HPXmVV
         AvOqAUO9NYIkzDa/NVhFvlbcRWbkQP1bJG5fButPhNY343Tkov2nfArmWS8SeQd9mK62
         1vr8HggZva7+iII98nboSiVjE3DMe52/nKtKunaczwnjHH/1hKjXVuk/mXEzg2CuV5j4
         tMA5qUl74Cy61jzwO/deC8FcVzcwoUpWp76CFFFlQiZBDnwxWhpwHPxnWkhgRKLCpl6S
         Dugg==
X-Forwarded-Encrypted: i=1; AFNElJ/nRl73crsMiYcQqACEn+fwXxYzrgJcXUoO0RVIREzWyRLEp4zh5prIBSL89Q6pjfzQogk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxW/H+BTQHSNtPw7JgZUBBbPegeMlchkkahortbpsT/aLrcL7b9
	6Z3qOENNLQctN+IVmfam0XOMWBSQ5c3CBq6w/y3d8X+N3AwTkFvzRgdhZR3HhkAz
X-Gm-Gg: Acq92OHHlbAKBYsKreiyny2sp1Rvt3aC6DcLHfGC6ylQhgyXplhG/p4ruslgp7Uia/h
	WHyj0+upAX1e9phEfi+CbWGIupXVbl58DbsthIb9toUqdKe8Mz2rHD69/qai4zpbyOU9kDME+8F
	CXkE0L0Hhn41BXdw/YvE/neVMRITFRy+Pu/Nv/xk/+wOsBgNTrNZS7OVLNdee0X2puEas925qHM
	wnHSap0YlsoffpA44TPZXeH8pBdlk7v2YSG6SX+nkLboDyDqPxG0tGZi5zTgZNPtefWxOzqsK4Q
	jEtGavpo7KsfSgUcufOktboTq1eyvfW1PJ4pBWmcNn+H3Oj2vqsm/eCqglmPs228lu5gZQ6zlna
	t5OtOo/ILtYrrEKuvfr0yCyzxH7dlEMFDRqphMWcerlgQuH1d74eGuo606jY1O7LUxS1DHrDpq7
	5yIfaLa62nnq/M9bRG2ocyfBkp8w/OA9pLR0su8aceRCHwD+zh0GlIAqUUhD6upuf2BtUEx8U=
X-Received: by 2002:ac8:7f8e:0:b0:50f:b9e7:3031 with SMTP id d75a77b69052e-51659fde5fcmr126194151cf.7.1778945338805;
        Sat, 16 May 2026 08:28:58 -0700 (PDT)
Received: from ?IPV6:2600:4040:264b:4100:d17e:f99:a560:8cad? ([2600:4040:264b:4100:d17e:f99:a560:8cad])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51664da7321sm39489551cf.22.2026.05.16.08.28.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 May 2026 08:28:58 -0700 (PDT)
Message-ID: <f654eab3-2157-4591-9ae0-440efb052e8e@gmail.com>
Date: Sat, 16 May 2026 11:28:57 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 10/11] git-gui: improve worktree discovery
To: Johannes Sixt <j6t@kdbg.org>
Cc: egg_mushroomcow@foxmail.com, bootaina702@gmail.com, git@vger.kernel.org
References: <50df7f28-c63c-4762-b542-b888ea3604c0@gmail.com>
 <20260514143322.865587-1-mlevedahl@gmail.com>
 <20260514143322.865587-11-mlevedahl@gmail.com>
 <8b8feffa-1651-41aa-ac76-d2721d656b45@kdbg.org>
Content-Language: en-US
From: Mark Levedahl <mlevedahl@gmail.com>
In-Reply-To: <8b8feffa-1651-41aa-ac76-d2721d656b45@kdbg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 5/16/26 4:16 AM, Johannes Sixt wrote:
> Am 14.05.26 um 16:33 schrieb Mark Levedahl:
>> git gui's worktree discovery needs update based upon prior work in this
>> series. In the normal case, all information we need comes directly from
>> git rev-parse (--show-toplevel, and --show-prefix). Should this work, we
>> have a valid worktree and all git gui commands can run.
>>
>> If not, we need to consider:
>> - if GIT_DIR or GIT_WORK_TREE are in the environment, just stop as we
>>   the input configuration was wrong, the user must fix that.
>> - if we have a browser or blame subcommand, no worktree is needed so
>>   git-gui can run without.
>> - using the git repository's parent is a valid worktree (if possible),
>>   restoring prior behavior.
>>
>> The current directory should be either the root of the worktree, if one
>> is found, or the top-level of the git repository.
> I disagree in the case where no working tree is found. Then there is no
> point in changing the current directory.

git-gui always changes to root of the worktree if that is found.
Failing to cd to the root of the repository when operating with no worktree opens the
possibility th
>
>> Make it so. Also, make worktree discover directly follow repository
>> discovery, reducing the locations that might need error trapping to
>> catch configuration issues.
> Good!
>
>> Signed-off-by: Mark Levedahl <mlevedahl@gmail.com>
> BTW, please make the subject line more descriptive. The word "improve"
> does not convey anything of importance.
>
>> ---
>>  git-gui.sh | 56 ++++++++++++++++++++++--------------------------------
>>  1 file changed, 23 insertions(+), 33 deletions(-)
>>
>> diff --git a/git-gui.sh b/git-gui.sh
>> index e326401..3a83dd5 100755
>> --- a/git-gui.sh
>> +++ b/git-gui.sh
>> @@ -1173,6 +1173,28 @@ if {[catch {
>>  	}
>>  }
>>  
>> +# find worktree, continue without if not required
>> +if {[catch {
>> +	set _gitworktree [git rev-parse --show-toplevel]
>> +	set _prefix [git rev-parse --show-prefix]
>> +	cd $_gitworktree
>> +} err]} {
> We have three commands, each with their own possible failure sources.
> One of the outcomes of an error is that we proceed anyway. I think that
> this is incorrect if the 'cd' fails: we must not proceed if it fails.
> Therefore, we must handle its failure separately.
>
>> +	if {[is_gitvars_error $err]} {
>> +		exit 1
>> +	}
>> +	set _gitworktree {}
>> +	set _prefix {}
>> +	if {[is_enabled bare]} {
>> +		cd $_gitdir
> Why change the directory here? If we run `git gui browser master dir` we
> do not want to change the directory in an uncontrolled manner. The
> argument parser will want to check for the existence of files, and then
> we do not want to operate from a random directory.
>
> Also, I think that the check must be for [is_bare] and not [is_enabled
> bare].

[is_enabled_bare] is correct. This code handles the case: 
    - neither the startup directory nor GIT_WORK_TREE are useable worktrees, so [is_bare]
is currently true.
    - the command given is browser or blame so a worktree is not needed. We can proceed.

The bigger question is whether to change directory at all: git-gui should never touch
files that are neither in the worktree nor in the repository. Leaving the current
directory as neither of those could be troublesome. I have no strong feeling here though,
will delete this.
    

>> +	} elseif {![is_parent_worktree]} {
>> +		catch {wm withdraw .}
>> +		error_popup [strcat [mc "Cannot use bare repository:"] "\n\n" $_gitdir]
>> +		exit 1
>> +	}
>> +}
>> +
>> +# repository and worktree config are complete, export them
>> +set_gitdir_vars
>>  
>>  # Use object format as hash algorithm (either "sha1" or "sha256")
>>  set hashalgorithm [git rev-parse --show-object-format]
> This moves code around. In particular, we see load_config and
> apply_config in the context below, which now happens only after these
> calls. How certain are we that these have no effect on the code that
> runs now earlier?
We need to load the system and user global config before running the repository picker. We
(re-) load the full config including the repository after we have a repository. I think
this is correct: git-config explicitly lists worktree dependent includeif statements,
meaning the config can be worktree dependent, and we must not load the final config until
repository and worktree discovery are complete.

git rev-parse, etc., perform discovery and config file loading each time they are invoked,
those are unaffected by git-gui's internal config.

I will clarify this explicitly in the commit message.

>> @@ -1189,37 +1211,8 @@ if {$hashalgorithm eq "sha1"} {
>>  load_config 0
>>  apply_config
>>  
>> -set _gitworktree [git rev-parse --show-toplevel]
>>  
>> -if {$_prefix ne {}} {
>> -	if {$_gitworktree eq {}} {
>> -		regsub -all {[^/]+/} $_prefix ../ cdup
>> -	} else {
>> -		set cdup $_gitworktree
>> -	}
>> -	if {[catch {cd $cdup} err]} {
>> -		catch {wm withdraw .}
>> -		error_popup [strcat [mc "Cannot move to top of working directory:"] "\n\n$err"]
>> -		exit 1
>> -	}
>> -	set _gitworktree [pwd]
>> -	unset cdup
>> -} elseif {![is_enabled bare]} {
>> -	if {[is_bare]} {
>> -		catch {wm withdraw .}
>> -		error_popup [strcat [mc "Cannot use bare repository:"] "\n\n$_gitdir"]
>> -		exit 1
>> -	}
>> -	if {$_gitworktree eq {}} {
>> -		set _gitworktree [file dirname $_gitdir]
>> -	}
>> -	if {[catch {cd $_gitworktree} err]} {
>> -		catch {wm withdraw .}
>> -		error_popup [strcat [mc "No working directory"] " $_gitworktree:\n\n$err"]
>> -		exit 1
>> -	}
>> -	set _gitworktree [pwd]
>> -}
>> +# Derive a human-readable repository name
>>  set _reponame [file split [file normalize $_gitdir]]
>>  if {[lindex $_reponame end] eq {.git}} {
>>  	set _reponame [lindex $_reponame end-1]
>> @@ -1227,9 +1220,6 @@ if {[lindex $_reponame end] eq {.git}} {
>>  	set _reponame [lindex $_reponame end]
>>  }
>>  
>> -# Export the final paths
>> -set_gitdir_vars
>> -
>>  ######################################################################
>>  ##
>>  ## global init
> -- Hannes
>

