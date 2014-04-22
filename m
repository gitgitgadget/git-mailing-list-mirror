From: Ronald Weiss <weiss.ronald@gmail.com>
Subject: Re: [PATCH v2.1] commit: add --ignore-submodules[=<when>] parameter
Date: Wed, 23 Apr 2014 00:21:17 +0200
Message-ID: <5356EB5D.2030503@gmail.com>
References: <CABxC_L92v=cV=+e_DNa0L6f21LB0BRP5duai2h_heGJN_PRoUQ@mail.gmail.com>	<5335A78C.60401@web.de>	<CABxC_L-4=qcZiix05dL8GrDJXv=19fw4yB0qFzRRfw=G=_Gxbg@mail.gmail.com>	<53374E49.9000702@gmail.com>	<533874F9.3090802@web.de>	<5338AC36.6000109@gmail.com>	<5338B1B0.3050703@gmail.com>	<5339BAE4.8020306@web.de> <CABxC_L8_tQrANXji_Z0LfigxsAuzSDj3K9ndTGOTHh2ctHvc6A@mail.gmail.com> <5339F122.60801@gmail.com> <5339FBB4.1010101@gmail.com> <533B2036.3050506@web.de> <533B36AA.3090600@gmail.com> <533C5CBD.4050601@web.de> <533C6B57.3080901@gmail.com> <534180BC.308@web.de> <53431CB8.2050600@gmail.com> <53443F5C.7050400@web.de> <5349CF3E.7010606@gmail.com> <53511A59.6000402@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Heiko Voigt <hvoigt@hvoigt.net>,
	Junio C Hamano <gitster@pobox.com>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Wed Apr 23 00:21:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wcj40-0007EX-V4
	for gcvg-git-2@plane.gmane.org; Wed, 23 Apr 2014 00:21:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753288AbaDVWVM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Apr 2014 18:21:12 -0400
Received: from mail-ee0-f42.google.com ([74.125.83.42]:47095 "EHLO
	mail-ee0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751402AbaDVWVK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Apr 2014 18:21:10 -0400
Received: by mail-ee0-f42.google.com with SMTP id d17so159488eek.15
        for <git@vger.kernel.org>; Tue, 22 Apr 2014 15:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=UIpYVjPfbN2t1Q69rv2//gbL72kg8j/GDv+y/caSNy8=;
        b=GWZ0MyTtIag/fGGsyQcwDJQPNHGup9+AGpTKNoyj1pRgTKKKc0KaMVM+H/gi8Y4wEH
         e85ZAuMt4TFGA4mE+FohOhPJRzBh2jAZABbMJ33IeQMnix0QuuYitFgpBs/2c87LAJV1
         xk7T+wzb7Kz4HgQay/FFtFmqvq7ZaUkO/hoiwFcmLihKMTW+g2S4SNpiQs6sm+8oLSxH
         UusJVVkINxFHkO85sOewKGT27glJ7Sxr7XLeDK1b/SqeEmQBbdZYFHsEUgEKQjbE3SaX
         cjRqEZKTCcD5xS25IShb9q5izq1O095uIcXYULkZ7hR+TQpKkpbf+yqUOrDHBrq5wRsb
         G96w==
X-Received: by 10.15.24.201 with SMTP id j49mr5275692eeu.99.1398205268999;
        Tue, 22 Apr 2014 15:21:08 -0700 (PDT)
Received: from [10.0.1.226] (chello089173067059.chello.sk. [89.173.67.59])
        by mx.google.com with ESMTPSA id q49sm460997eem.34.2014.04.22.15.21.07
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 22 Apr 2014 15:21:08 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.4.0
In-Reply-To: <53511A59.6000402@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246795>

On 18. 4. 2014 14:28, Jens Lehmann wrote:
> Am 13.04.2014 01:41, schrieb Ronald Weiss:
>> Second, there are some differences between adding standard ignored
>> files, and ignored submodules:
>>
>> 1) Already tracked files are never ignored, regardless of .gitignore.
>>   However, tracked submodules should be ignored by "add -u", if told so
>>   by their ignore setting.
>>
>> 2) So .gitignore seems to only do something when adding new files to
>>   the repo. However, when adding new submodules, they are probably never
>>   ignored (setting the ignore setting for non existent submodule seems
>>   like non-sense, although possible).
> 
> What about "diff.ignoreSubmodules=all"?
> 
>> 3) Ignored files can be ignored less explicitely (in global gitignore,
>>   or using a wildcard, or by ignoring parent folder). So it makes sense
>>   to warn the user if he tries to explicitely add an ignored file, as he
>>   might not be aware that the file is ignored. Submodules, however, can
>>   only be ignored explicitely. And when user explicitely specifies the
>>   submodule in an add command, he most probably really wants to add it,
>>   so I don't see the point in warning him and requiring the -f option.
> 
> But we do have "diff.ignoreSubmodules=all", so I do not agree with
> your conclusion.

Ah, I didn't know about diff.ignoreSubmodules. I agree that it defeats
two of my points :-(.

And how about the point 1), should submodules never be ignored once
already tracked, like standard ignored files? I'm almost sure that in
this case the behavior should be different, otherwise it would drop
the most useful use case of the proposed change.

>> So, I think that the use cases are completely different, for submodules
>> and ignored files. So trying to make add behave the same for both, might
>> not be that good idea.
>>
>> I would propose - let's make add honor the ignore setting by just
>> parsing if from config like the other commands do, and pass it to
>> underlying diff invocations. And at the same the, let's override it for
>> submodules explicitely specified on the command line, to never ignore
>> such submodules, without requiring the -f option. That seems to be
>> pretty easy, see below.
> 
> What about doing that only when '-f' is given? Would that do what we
> want?

OK then, seems right with diff.ignoreSubmodules in mind.

But one question stays - what to do with submodules not explicitly
specified on command line (when their parent folder is being added)?
You adviced already to do what we do with standard ignored files. That
seems to be:

A) if the file is already tracked, add it
B) if not tracked, without -f, silently ignore it
C) if not tracked, with -f, add it

A) is same like point 1 above, let's forget it until we settle that one.
But B) is even more problematic, we would probably have to modify the
directory parsing code in dir.c to handle ignored submodules. Is that
what we want? If so, then I'm afraid this is getting overly complicated.

>> @@ -320,6 +324,7 @@ int cmd_add(int argc, const char **argv, const char *prefix)
>>   	char *seen = NULL;
>>   
>>   	git_config(add_config, NULL);
>> +	gitmodules_config();
> 
> Wrong order, gitmodules_config() must be called before git_config()
> to make the .gitmodules settings overridable by the users config.

Right. I noticed that too just after sending the patch.

>> @@ -440,6 +446,18 @@ int cmd_add(int argc, const char **argv, const char *prefix)
>>   					die(_("pathspec '%s' did not match any files"),
>>   					    pathspec.items[i].original);
>>   			}
>> +
>> +			/* disable ignore setting for any submodules specified explicitly in the pathspec */
>> +			if (path[0] &&
>> +				(cachepos = cache_name_pos(path, pathspec.items[i].len)) >= 0 &&
>> +				S_ISGITLINK(active_cache[cachepos]->ce_mode)) {
>> +				char *optname;
>> +				int optnamelen = pathspec.items[i].len + 17;
>> +				optname = xcalloc(optnamelen + 1, 1);
>> +				snprintf(optname, optnamelen + 1, "submodule.%s.ignore", path);
>> +				parse_submodule_config_option(optname, "none");
> 
> We should use "dirty" instead of "none" here. Modifications inside
> the submodule cannot be added without committing them there first
> and using "none" might incur an extra preformance penalty for
> looking through the submodule directories for such changes.

OK, that's right too.
