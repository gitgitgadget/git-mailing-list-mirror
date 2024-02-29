Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6711F7AE73
	for <git@vger.kernel.org>; Thu, 29 Feb 2024 11:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709205407; cv=none; b=LHr3GX/jRoAcwad69892bVKxa0PCINmUaKkhthHL5drv3HuVa1n0GqhUFHWjOK8VGCuxKehENAI8X5v0s4oLhbfAYKCwPOZ7K2pDmkcHwnMhbLuWtbekafT/UhK+a9dsPl9qnqf7JE55Y79q+OG8KN82Wb3UFc9ZET5GL7Xt5cE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709205407; c=relaxed/simple;
	bh=FSvpO9sqIf2/upCa3BymWXn1rf0AxWag6hwODwnt5uU=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=MpiW3zRUVixw05QC9ynaXXvbRRDL0HOHbM+PPGNyKBh/bSYUwZnkP7fMnQWif80cHiqZKyyA0+i+kZl6lmx98sBSkFyQaPzS8hTeL0FoJCS4oMfDrD/X9P+DvT6jkL/4s2bXVNO8fxXWbQWUD71qL25RtKcVVSidib6cenOaXA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HclKP/OC; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HclKP/OC"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-33d36736d4eso515986f8f.1
        for <git@vger.kernel.org>; Thu, 29 Feb 2024 03:16:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709205403; x=1709810203; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=QBibt9oyzoe9TJayeb5SebEA1Uf/LlFwbifqKZibAYA=;
        b=HclKP/OCynf3yVApx7LfgqgkKY5z7hZMbR302sat9lpuE+yqn5e2JNdS1KysraHEnh
         mSh+XoVPkdAj/RsFv9PPiTibsDk4HJEtf7V8n4rjz0TI+TZeJLUfI1vxn/v+WcpxIqR6
         RwNbcVJu9TeuQdJjVW/rFONySasdlMYuLPC5S6N7C4fNcmjp/YhH9QjOLGyi9s+PjpFj
         HspPlBmrpqf42VHPucTXGaJN6FPs4WEyWfZgCl+Y6nz4hyQodQ6P+p9j178qkBz20GWo
         zC/AMYBQm/auP0wf8xdyYIJGmcWXcUZGZACsSgayKzYlcUTPMITHHCP4+iy9p9qCdn2s
         fjew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709205403; x=1709810203;
        h=content-transfer-encoding:in-reply-to:reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QBibt9oyzoe9TJayeb5SebEA1Uf/LlFwbifqKZibAYA=;
        b=q7/Tx0nzLFKsOrfUQAl1YOy2hU9bOQhyLeemP+OUw9NzzDzJdLe/ThNFIYlR81ksm9
         3aqDqmNJoI2poGto01dfBmLJsL/hgTGQN36VwBvxnJMJyx1gYz2ASgdOFl908Qs6Xvi4
         QGwa66eZ4aMKnrrxQdc3j0z0kUYZEYRyRWCDjvY0gD/LKnVukZaGuJAHY9tS+VudyvCx
         MCMDCp1nmeHUqUaa6wdxc1tQ9IbE1dHxSSyLz/hd3hplnOdSV1z1HNqLc9ZtqFWO03/D
         twRIz+qIDsWz37PBPdRaCPbDBEuezRmS9YAZj9V+yIcGe+hVZ36OvnrfzD6A7ebvTFXP
         o9RA==
X-Forwarded-Encrypted: i=1; AJvYcCVwcxUmmqF/8whZ70oYdCGyQA4WKb30e3SyYrCxRafsanYxhbAlYyJbmTsXoUEJmqkk9t/D4Zaims90ClXTr3R2eFfH
X-Gm-Message-State: AOJu0YwNGMQ8VyoQKWV0hlnSzvZzqYsXHvzMUN3MyqOeP8QxS+9gNDnJ
	J8rhEJ+HYVK7s7PtEmHsYAdrlDKypHQWbYf4DuOj8eR8jEFA3ff5iOJ9SVTC
X-Google-Smtp-Source: AGHT+IF8XSLCBCjZDIbM5zQzocYSW/n+vkAGqBVmsotNG/DvcaBaM6mben5Dv59sWAMZCgWIk5T/Uw==
X-Received: by 2002:adf:e0cc:0:b0:33d:6bd3:9e28 with SMTP id m12-20020adfe0cc000000b0033d6bd39e28mr1072932wri.70.1709205402393;
        Thu, 29 Feb 2024 03:16:42 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:69d:3501:d2c6:37ff:fef6:7b1? ([2a0a:ef40:69d:3501:d2c6:37ff:fef6:7b1])
        by smtp.googlemail.com with ESMTPSA id bp16-20020a5d5a90000000b0033e0567e90bsm1563301wrb.5.2024.02.29.03.16.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Feb 2024 03:16:42 -0800 (PST)
Message-ID: <db8b2398-c6d6-47a1-a4d4-7e4726d13312@gmail.com>
Date: Thu, 29 Feb 2024 11:16:41 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v5 2/3] git-std-lib: introduce Git Standard Library
To: Calvin Wan <calvinwan@google.com>, git@vger.kernel.org
Cc: Jonathan Tan <jonathantanmy@google.com>,
 Junio C Hamano <gitster@pobox.com>
References: <cover.1696021277.git.jonathantanmy@google.com>
 <20240222175033.1489723-3-calvinwan@google.com>
Content-Language: en-US
Reply-To: phillip.wood@dunelm.org.uk
In-Reply-To: <20240222175033.1489723-3-calvinwan@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Calvin

On 22/02/2024 17:50, Calvin Wan wrote:
> This commit contains:
> - Makefile rules for git-std-lib.a
> - code and Makefile rules for git-stub-lib.a
> - description and rationale of the above in Documentation/

We tend to avoid lists like this in our commit messages. Starting with 
the motivation for adding git-std-lib would be more helpful to the 
reader I think.

> Quoting from documentation introduced in this commit:
> 
>    The Git Standard Library intends to serve as the foundational library
>    and root dependency that other libraries in Git will be built off
>    of. That is to say, suppose we have libraries X and Y; a user that
>    wants to use X and Y would need to include X, Y, and this Git Standard
>    Library.
> 
> Code demonstrating the use of git-std-lib.a and git-stub-lib.a will be
> in a subsequent commit.
> 
> Signed-off-by: Calvin Wan <calvinwan@google.com>
> Helped-by: Phillip Wood <phillip.wood123@gmail.com>
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>

I think virtually all the changes since the last version apart from 
rewording the documentation come from my fixup at [1] I'm happy to offer 
my Signed-off-by: for those. I cannot offer a review of the changes from 
that fixup though I'm still happy with the approach. I do however think 
I should have included git-compat-util.h in the stub implementations and 
used BUG() instead of assert(). I've left some comments on the 
documentation below.

[1] 
https://github.com/phillipwood/git/commit/0f8393d2189a4c73d3f00f5ae74d3972677309d0

> diff --git a/Documentation/technical/git-std-lib.txt b/Documentation/technical/git-std-lib.txt
> new file mode 100644
> index 0000000000..3d9aa121ac
> --- /dev/null
> +++ b/Documentation/technical/git-std-lib.txt
> @@ -0,0 +1,170 @@
> += Git Standard Library
> +
> +The Git Standard Library intends to serve as the foundational library
> +and root dependency that other libraries in Git will be built off of.
> +That is to say, suppose we have libraries X and Y; a user that wants to
> +use X and Y would need to include X, Y, and this Git Standard Library.
> +This does not mean that the Git Standard Library will be the only
> +possible root dependency in the future, but rather the most significant
> +and widely used one. Git itself is also built off of the Git Standard
> +Library.
> +
> +== Dependency graph in libified Git
> +
> +Before the introduction of the Git Standard Library, all objects defined
> +in the Git library are compiled and archived into a singular file,

s/singular/single/ there are some instances of "singular" later on as 
well all of which would be better as "single" I think.

> +libgit.a, which is then linked against by common-main.o with other
> +external dependencies and turned into the Git executable.

I found this description a bit confusing. As I understand it to build 
git we link git.o against common-main.o, libgit.a, xdiff/lib.a, 
reftable/libreftable.a and libpcre etc.

> In other
> +words, the Git executable has dependencies on libgit.a and a couple of
> +external libraries. The libfication of Git slightly alters this build
> +flow by separating out libgit.a into libgit.a and git-std-lib.a.
> +
> +With our current method of building Git, we can imagine the dependency

s/imagine/visualize/

> +graph as such:
> +
> +	Git
> +	 /\
> +	/  \
> +       /    \
> +  libgit.a   ext deps
> +
> +We want to separate out potential libraries from libgit.a and have
> +libgit.a depend on them, which would possibly look like:
> +
> +		Git
> +		/\
> +	       /  \
> +	      /    \
> +	  libgit.a  ext deps
> +	     /\
> +	    /  \
> +	   /    \
> +object-store.a  (other lib)
> +      |        /
> +      |       /
> +      |      /
> +      |     /
> +      |    /
> +      |   /
> +      |  /
> +git-std-lib.a
> +
> +Instead of containing all objects in Git, libgit.a would contain objects
> +that are not built by libraries it links against. Consequently, if

s/by libraries/by the libraries/

> +someone wanted a custom build of Git with a custom implementation of the
> +object store, they would only have to swap out object-store.a rather
> +than do a hard fork of Git.
> +
> +== Rationale behind Git Standard Library
> +
> +The rationale behind the selected object files in the Git Standard
> +Library is the result of two observations within the Git
> +codebase:
> +  1. every file includes git-compat-util.h which defines functions
> +     in a couple of different files
> +  2. wrapper.c + usage.c have difficult-to-separate circular

s/+/and/

> +     dependencies with each other and other files.
> +
> +=== Ubiquity of git-compat-util.h and circular dependencies
> +
> +Every file in the Git codebase includes git-compat-util.h. It serves as
> +"a compatibility aid that isolates the knowledge of platform specific
> +inclusion order and what feature macros to define before including which
> +system header" (Junio[1]). Since every file includes git-compat-util.h,
> +and git-compat-util.h includes wrapper.h and usage.h, it would make
> +sense for wrapper.c and usage.c to be a part of the root library. They
> +have difficult to separate circular dependencies with each other so it
> +would impractical for them to be independent libraries. Wrapper.c has
> +dependencies on parse.c, abspath.c, strbuf.c, which in turn also have
> +dependencies on usage.c and wrapper.c - more circular dependencies.
> +
> +=== Tradeoff between swappability and refactoring
> +
> +From the above dependency graph, we can see that git-std-lib.a could be
> +many smaller libraries rather than a singular library. So why choose a
> +singular library when multiple libraries can be individually easier to
> +swap and are more modular? A singular library requires less work to
> +separate out circular dependencies within itself so it becomes a
> +tradeoff question between work and reward. While there may be a point in
> +the future where a file like usage.c would want its own library so that
> +someone can have custom die() or error(), the work required to refactor
> +out the circular dependencies in some files would be enormous due to
> +their ubiquity so therefore I believe it is not worth the tradeoff

I'm not sure if we want to use the first person in our technical 
documentation, unlike the cover letter to a patch series it is not 
immediately obvious to the reader who "I" is. This applies the passages 
in the first person below as well.

> +currently. Additionally, we can in the future choose to do this refactor
> +and change the API for the library if there becomes enough of a reason
> +to do so (remember we are avoiding promising stability of the interfaces
> +of those libraries).
> +
> +=== Reuse of compatibility functions in git-compat-util.h
> +
> +Most functions defined in git-compat-util.h are implemented in compat/
> +and have dependencies limited to strbuf.h and wrapper.h so they can be
> +easily included in git-std-lib.a, which as a root dependency means that
> +higher level libraries do not have to worry about compatibility files in
> +compat/. The rest of the functions defined in git-compat-util.h are
> +implemented in top level files and are hidden behind
> +an #ifdef if their implementation is not in git-std-lib.a.

I think the reference to #ifdef is out of date now we've moved to more stubs

> +=== Rationale summary
> +
> +The Git Standard Library allows us to get the libification ball rolling
> +with other libraries in Git. By not spending many more months attempting
> +to refactor difficult circular dependencies and instead spending that
> +time getting to a state where we can test out swapping a library out
> +such as config or object store, we can prove the viability of Git
> +libification on a much faster time scale. Additionally the code cleanups
> +that have happened so far have been minor and beneficial for the
> +codebase. It is probable that making large movements would negatively
> +affect code clarity.
> +
> +== Git Standard Library boundary
> +
> +While I have described above some useful heuristics for identifying
> +potential candidates for git-std-lib.a, a standard library should not
> +have a shaky definition for what belongs in it.

Maybe "we need a more precise definition" rather than the "shaky 
definition" bit

> + - Low-level files (aka operates only on other primitive types) that are
> +   used everywhere within the codebase (wrapper.c, usage.c, strbuf.c)
> +   - Dependencies that are low-level and widely used
> +     (abspath.c, date.c, hex-ll.c, parse.c, utf8.c)
> + - low-level git/* files with functions defined in git-compat-util.h
> +   (ctype.c)
> + - compat/*
> +
> +There are other files that might fit this definition, but that does not
> +mean it should belong in git-std-lib.a. Those files should start as
> +their own separate library since any file added to git-std-lib.a loses
> +its flexibility of being easily swappable.
> +
> +Wrapper.c and usage.c have dependencies on pager and trace2 that are
> +possible to remove at the cost of sacrificing the ability for standard Git
> +to be able to trace functions in those files and other files in git-std-lib.a.
> +In order for git-std-lib.a to compile with those dependencies, stubbed out
> +versions of those files are implemented and swapped in during compilation time
> +(see STUB_LIB_OBJS in the Makefile).
> +
> +== Files inside of Git Standard Library
> +
> +The set of files in git-std-lib.a can be found in STD_LIB_OBJS and COMPAT_OBJS
> +in the Makefile.
> +
> +When these files are compiled together with the files in STUB_LIB_OBJS (or
> +user-provided files that provide the same functions), they form a complete
> +library.
> +
> +== Pitfalls
> +
> +There are a small amount of files under compat/* that have dependencies

s/amount/number/ as files are countable

> +not inside of git-std-lib.a. While those functions are not called on
> +Linux, other OSes might call those problematic functions. I don't see
> +this as a major problem, just moreso an observation that libification in
> +general may also require some minor compatibility work in the future.
> +
> +== Testing
> +
> +Unit tests should catch any breakages caused by changes to files in
> +git-std-lib.a (i.e. introduction of a out of scope dependency) and new
> +functions introduced to git-std-lib.a will require unit tests written

s/test written/tests to be written/

> +for them.
> +
> +[1] https://lore.kernel.org/git/xmqqwn17sydw.fsf@gitster.g/

It is nice to see us compiling git using git-std-lib.

Best Wishes

Phillip

> diff --git a/Makefile b/Makefile
> index 4e255c81f2..d37ea9d34b 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -669,6 +669,8 @@ FUZZ_PROGRAMS =
>   GIT_OBJS =
>   LIB_OBJS =
>   SCALAR_OBJS =
> +STD_LIB_OBJS =
> +STUB_LIB_OBJS =
>   OBJECTS =
>   OTHER_PROGRAMS =
>   PROGRAM_OBJS =
> @@ -923,6 +925,8 @@ TEST_SHELL_PATH = $(SHELL_PATH)
>   
>   LIB_FILE = libgit.a
>   XDIFF_LIB = xdiff/lib.a
> +STD_LIB_FILE = git-std-lib.a
> +STUB_LIB_FILE = git-stub-lib.a
>   REFTABLE_LIB = reftable/libreftable.a
>   REFTABLE_TEST_LIB = reftable/libreftable_test.a
>   
> @@ -962,7 +966,6 @@ COCCI_SOURCES = $(filter-out $(THIRD_PARTY_SOURCES),$(FOUND_C_SOURCES))
>   
>   LIB_H = $(FOUND_H_SOURCES)
>   
> -LIB_OBJS += abspath.o
>   LIB_OBJS += add-interactive.o
>   LIB_OBJS += add-patch.o
>   LIB_OBJS += advice.o
> @@ -1004,8 +1007,6 @@ LIB_OBJS += convert.o
>   LIB_OBJS += copy.o
>   LIB_OBJS += credential.o
>   LIB_OBJS += csum-file.o
> -LIB_OBJS += ctype.o
> -LIB_OBJS += date.o
>   LIB_OBJS += decorate.o
>   LIB_OBJS += delta-islands.o
>   LIB_OBJS += diagnose.o
> @@ -1046,7 +1047,6 @@ LIB_OBJS += hash-lookup.o
>   LIB_OBJS += hashmap.o
>   LIB_OBJS += help.o
>   LIB_OBJS += hex.o
> -LIB_OBJS += hex-ll.o
>   LIB_OBJS += hook.o
>   LIB_OBJS += ident.o
>   LIB_OBJS += json-writer.o
> @@ -1097,7 +1097,6 @@ LIB_OBJS += pack-write.o
>   LIB_OBJS += packfile.o
>   LIB_OBJS += pager.o
>   LIB_OBJS += parallel-checkout.o
> -LIB_OBJS += parse.o
>   LIB_OBJS += parse-options-cb.o
>   LIB_OBJS += parse-options.o
>   LIB_OBJS += patch-delta.o
> @@ -1152,7 +1151,6 @@ LIB_OBJS += sparse-index.o
>   LIB_OBJS += split-index.o
>   LIB_OBJS += stable-qsort.o
>   LIB_OBJS += statinfo.o
> -LIB_OBJS += strbuf.o
>   LIB_OBJS += streaming.o
>   LIB_OBJS += string-list.o
>   LIB_OBJS += strmap.o
> @@ -1189,21 +1187,32 @@ LIB_OBJS += unpack-trees.o
>   LIB_OBJS += upload-pack.o
>   LIB_OBJS += url.o
>   LIB_OBJS += urlmatch.o
> -LIB_OBJS += usage.o
>   LIB_OBJS += userdiff.o
> -LIB_OBJS += utf8.o
>   LIB_OBJS += varint.o
>   LIB_OBJS += version.o
>   LIB_OBJS += versioncmp.o
>   LIB_OBJS += walker.o
>   LIB_OBJS += wildmatch.o
>   LIB_OBJS += worktree.o
> -LIB_OBJS += wrapper.o
>   LIB_OBJS += write-or-die.o
>   LIB_OBJS += ws.o
>   LIB_OBJS += wt-status.o
>   LIB_OBJS += xdiff-interface.o
>   
> +STD_LIB_OBJS += abspath.o
> +STD_LIB_OBJS += ctype.o
> +STD_LIB_OBJS += date.o
> +STD_LIB_OBJS += hex-ll.o
> +STD_LIB_OBJS += parse.o
> +STD_LIB_OBJS += strbuf.o
> +STD_LIB_OBJS += usage.o
> +STD_LIB_OBJS += utf8.o
> +STD_LIB_OBJS += wrapper.o
> +
> +STUB_LIB_OBJS += stubs/trace2.o
> +STUB_LIB_OBJS += stubs/pager.o
> +STUB_LIB_OBJS += stubs/misc.o
> +
>   BUILTIN_OBJS += builtin/add.o
>   BUILTIN_OBJS += builtin/am.o
>   BUILTIN_OBJS += builtin/annotate.o
> @@ -1352,7 +1361,7 @@ UNIT_TEST_OBJS = $(patsubst %,$(UNIT_TEST_DIR)/%.o,$(UNIT_TEST_PROGRAMS))
>   UNIT_TEST_OBJS += $(UNIT_TEST_DIR)/test-lib.o
>   
>   # xdiff and reftable libs may in turn depend on what is in libgit.a
> -GITLIBS = common-main.o $(LIB_FILE) $(XDIFF_LIB) $(REFTABLE_LIB) $(LIB_FILE)
> +GITLIBS = common-main.o $(STD_LIB_FILE) $(LIB_FILE) $(XDIFF_LIB) $(REFTABLE_LIB) $(LIB_FILE)
>   EXTLIBS =
>   
>   GIT_USER_AGENT = git/$(GIT_VERSION)
> @@ -2693,6 +2702,8 @@ OBJECTS += $(XDIFF_OBJS)
>   OBJECTS += $(FUZZ_OBJS)
>   OBJECTS += $(REFTABLE_OBJS) $(REFTABLE_TEST_OBJS)
>   OBJECTS += $(UNIT_TEST_OBJS)
> +OBJECTS += $(STD_LIB_OBJS)
> +OBJECTS += $(STUB_LIB_OBJS)
>   
>   ifndef NO_CURL
>   	OBJECTS += http.o http-walker.o remote-curl.o
> @@ -3686,7 +3697,7 @@ clean: profile-clean coverage-clean cocciclean
>   	$(RM) git.res
>   	$(RM) $(OBJECTS)
>   	$(RM) headless-git.o
> -	$(RM) $(LIB_FILE) $(XDIFF_LIB) $(REFTABLE_LIB) $(REFTABLE_TEST_LIB)
> +	$(RM) $(LIB_FILE) $(XDIFF_LIB) $(REFTABLE_LIB) $(REFTABLE_TEST_LIB) $(STD_LIB_FILE) $(STUB_LIB_FILE)
>   	$(RM) $(ALL_PROGRAMS) $(SCRIPT_LIB) $(BUILT_INS) $(OTHER_PROGRAMS)
>   	$(RM) $(TEST_PROGRAMS)
>   	$(RM) $(FUZZ_PROGRAMS)
> @@ -3878,3 +3889,18 @@ $(UNIT_TEST_PROGS): $(UNIT_TEST_BIN)/%$X: $(UNIT_TEST_DIR)/%.o $(UNIT_TEST_DIR)/
>   build-unit-tests: $(UNIT_TEST_PROGS)
>   unit-tests: $(UNIT_TEST_PROGS)
>   	$(MAKE) -C t/ unit-tests
> +
> +### Libified Git rules
> +
> +# git-std-lib.a
> +# Programs other than git should compile this with
> +#     make NO_GETTEXT=YesPlease git-std-lib.a
> +# and link against git-stub-lib.a (if the default no-op functionality is fine)
> +# or a custom .a file with the same interface as git-stub-lib.a (if custom
> +# functionality is needed) as well.
> +$(STD_LIB_FILE): $(STD_LIB_OBJS) $(COMPAT_OBJS)
> +	$(QUIET_AR)$(RM) $@ && $(AR) $(ARFLAGS) $@ $^
> +
> +# git-stub-lib.a
> +$(STUB_LIB_FILE): $(STUB_LIB_OBJS)
> +	$(QUIET_AR)$(RM) $@ && $(AR) $(ARFLAGS) $@ $^
> diff --git a/stubs/misc.c b/stubs/misc.c
> new file mode 100644
> index 0000000000..92da76fd46
> --- /dev/null
> +++ b/stubs/misc.c
> @@ -0,0 +1,33 @@
> +#include <assert.h>
> +#include <stdlib.h>
> +
> +#ifndef NO_GETTEXT
> +/*
> + * NEEDSWORK: This is enough to link our unit tests against
> + * git-std-lib.a built with gettext support. We don't really support
> + * programs other than git using git-std-lib.a with gettext support
> + * yet. To do that we need to start using dgettext() rather than
> + * gettext() in our code.
> + */
> +int git_gettext_enabled = 0;
> +#endif
> +
> +int common_exit(const char *file, int line, int code);
> +
> +int common_exit(const char *file, int line, int code)
> +{
> +	exit(code);
> +}
> +
> +#if !defined(__MINGW32__) && !defined(_MSC_VER)
> +int lstat_cache_aware_rmdir(const char *path);
> +
> +int lstat_cache_aware_rmdir(const char *path)
> +{
> +	/*
> +	 * This function should not be called by programs linked
> +	 * against git-stub-lib.a
> +	 */
> +	assert(0);
> +}
> +#endif
> diff --git a/stubs/pager.c b/stubs/pager.c
> new file mode 100644
> index 0000000000..4f575cada7
> --- /dev/null
> +++ b/stubs/pager.c
> @@ -0,0 +1,6 @@
> +#include "pager.h"
> +
> +int pager_in_use(void)
> +{
> +	return 0;
> +}
> diff --git a/stubs/trace2.c b/stubs/trace2.c
> new file mode 100644
> index 0000000000..7d89482228
> --- /dev/null
> +++ b/stubs/trace2.c
> @@ -0,0 +1,27 @@
> +#include "git-compat-util.h"
> +#include "trace2.h"
> +
> +struct child_process { int stub; };
> +struct repository { int stub; };
> +struct json_writer { int stub; };
> +
> +void trace2_region_enter_fl(const char *file, int line, const char *category,
> +			    const char *label, const struct repository *repo, ...) { }
> +void trace2_region_leave_fl(const char *file, int line, const char *category,
> +			    const char *label, const struct repository *repo, ...) { }
> +void trace2_data_string_fl(const char *file, int line, const char *category,
> +			   const struct repository *repo, const char *key,
> +			   const char *value) { }
> +void trace2_cmd_ancestry_fl(const char *file, int line, const char **parent_names) { }
> +void trace2_cmd_error_va_fl(const char *file, int line, const char *fmt,
> +			    va_list ap) { }
> +void trace2_cmd_name_fl(const char *file, int line, const char *name) { }
> +void trace2_thread_start_fl(const char *file, int line,
> +			    const char *thread_base_name) { }
> +void trace2_thread_exit_fl(const char *file, int line) { }
> +void trace2_data_intmax_fl(const char *file, int line, const char *category,
> +			   const struct repository *repo, const char *key,
> +			   intmax_t value) { }
> +int trace2_is_enabled(void) { return 0; }
> +void trace2_counter_add(enum trace2_counter_id cid, uint64_t value) { }
> +void trace2_collect_process_info(enum trace2_process_info_reason reason) { }
