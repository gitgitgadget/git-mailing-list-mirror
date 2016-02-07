From: Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [RFC] On the --depth argument when fetching with submodules
Date: Sun, 7 Feb 2016 14:32:26 +0100
Message-ID: <FA2DA97F-D944-4784-8297-E2885F197AC0@gmail.com>
References: <CAGZ79kbt2-Vm94eTQY0PmJrNwqyTa36FJy5Q+2YBsxu6uYdTmQ@mail.gmail.com> <xmqqoabubt5e.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Stefan Beller <sbeller@google.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 07 14:32:36 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aSPS7-0004Es-UM
	for gcvg-git-2@plane.gmane.org; Sun, 07 Feb 2016 14:32:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753925AbcBGNcb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Feb 2016 08:32:31 -0500
Received: from mail-wm0-f51.google.com ([74.125.82.51]:37921 "EHLO
	mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753516AbcBGNca convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 7 Feb 2016 08:32:30 -0500
Received: by mail-wm0-f51.google.com with SMTP id p63so83818338wmp.1
        for <git@vger.kernel.org>; Sun, 07 Feb 2016 05:32:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=content-type:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=V0wTKmzfKz2i6Jw7VjEFf8eOgQTjTBx13lB1Sh04zEs=;
        b=R1xFSxPLJvPR7WYwVIsbtHIb4usJBxPFkETmVAp0kYDYPY3pDVvbhJlThRLrT64enJ
         rPs9tLFW/drj09toSD3FgVebbuA0MhAL7enQTGZgJqsdCzwi7/HryayCcfQ+YLeeNo1Q
         SdzRh83Rx4sugr4NMdEPjlzCxZVbWN8n8X1QTEnTo34hxbjjNuDL0HsVZ2O5J88wf0MR
         +XfxgE6pmbHi49rN5a8xBhwKy050PYEDyfDMNhWYJo5Sjx+QXqRvqOU5t5hZezam8o1t
         JKQL9OC9U3g60vR8sKlh2QozKjyO9vb+x5+SZ66ird3qonqjf0fRVL80M1Fx+TQ0XXBl
         tOoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:content-type:mime-version:subject:from
         :in-reply-to:date:cc:content-transfer-encoding:message-id:references
         :to;
        bh=V0wTKmzfKz2i6Jw7VjEFf8eOgQTjTBx13lB1Sh04zEs=;
        b=eRZZwnH70SybnFF4Qd5QBDyxtI0xIE/uz6OlqjrJSFfsO6/DQDM+VPTimgKqv6pXcl
         AdrIOeseFEmKeOkxN1uxJnvULfjWL83Mgha16LxCRqIJAxGBFk/T4qhlLbGWwpxPqebW
         id+fYpvHjVXqt8Ae9IbqSqKOca3C/Bnqmq4JPaWTwuMnCuQ7iNIdzYOfLueV8r++Whln
         37oFIDK9Uw4pHg9QsbGz2goH3Y3i8bDHugtby+Xbo5BZtF11t5A8WfNptq2mXytBsUVF
         3HvVJvEnKP0wggIACkAvaS/dDFkLDHs4J9YkwYLfP1yfyFpstpW16McPyYkdvfXrrs1o
         9AAQ==
X-Gm-Message-State: AG10YORJV3LWPD30JtIJBr8XecBHX4QIdZ3ZJaf3h/UV3AyJQnLX3WMOX77//R0IsDvbEA==
X-Received: by 10.28.6.213 with SMTP id 204mr25273797wmg.47.1454851949318;
        Sun, 07 Feb 2016 05:32:29 -0800 (PST)
Received: from slxbook3.fritz.box (p5DDB606F.dip0.t-ipconnect.de. [93.219.96.111])
        by smtp.gmail.com with ESMTPSA id g3sm24908794wjw.31.2016.02.07.05.32.27
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 07 Feb 2016 05:32:28 -0800 (PST)
In-Reply-To: <xmqqoabubt5e.fsf@gitster.mtv.corp.google.com>
X-Mailer: Apple Mail (2.1878.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285727>


On 06 Feb 2016, at 01:05, Junio C Hamano <gitster@pobox.com> wrote:

> Stefan Beller <sbeller@google.com> writes:
> 
>> Currently when cloning a project, including submodules, the --depth argument
>> is passed on recursively, i.e. when cloning with "--depth 2", both the
>> superproject as well as the submodule will have a depth of 2.  It is not
>> garantueed that the commits as specified by the superproject are included
>> in these 2 commits of the submodule.
>> 
>> Illustration:
>> (superproject with depth 2, so A would have more parents, not shown)
>> 
>> superproject/master: A <- B
>>                    /      \
>> submodule/master:  C <- D <- E <- F <- G
>> 
>> (Current behavior is to fetch G and F)
> 
> I think the issue is deeper than merely "--depth 2", and you would
> be better off stepping back and think about various use cases to
> make sure that we know what kind of behaviour we want to support
> before delving into one particular corner case.  We currently pass
> the depth recursively, and I do not think it makes much sense, but I
> view it as a secondary question "among the behaviours we want to
> support, which one should be the default?"  It may turn out that not
> passing it recursively at all, or even passing a different depth, is
> a better default, but we wouldn't know until we know what are the
> desirable behaviour in various workflows.
> 
> If you are actively working on the superproject plus some submodules
> but you are merely using the submodule you depicted above, not
> working on changing it, even when you want the full history of the
> superproject (i.e. no "--depth 2"), you may not want history of the
> submodule.  Even though we have a way to say "I am not interested in
> this submodule AT ALL" by not doing "submodule init", not having
> anything at all at the path submodule/ may not allow you to build
> the whole thing, and we currently lack a way to express "I am not
> interested in the history of this thing, but I need at least the
> tree that matches the commit referred to by the superproject".
> 
> If you are working on a single submodule, trying to fix a bug in the
> context of the whole project, you might want to have a single-depth
> clone of the superproject and all other submodules, plus the whole
> history of the single submodule.
> 
> In either of these examples, the top-level "--depth" does not have
> much to do with what depth the user wants to use when cloning or
> fetching the submodule repositories.
> 
> I have a feeling (but I would not be surprised if somebody who uses
> submodules heavily has a counter-example from real life) that
> regardless of "--depth" or full clone, fetching the tip of matching
> branch is not a good default behaviour.  In your picture, even when
> depth is not given at all, there isn't much point fetching F or G.

I really wonder in what cases people use the "--depth" option, too. 
For instance I have never used it in either one of the two cases you
described above. I don't worry about a long running "clone" as it 
usually is a one-time operation.

However, in case of a continuous integration system that starts with
a clean state in the beginning of every run (e.g. Travis CI) a
"clone" operation is no one-time operation anymore. In this case the
"--depth 1" option makes very much sense to me. This was the situation
where I realized the problem that Stefan wants to tackle here and I
tried to make it tangible with a test case [1]. 

On top of that I think Git's error message is really confusing if
you clone a repo with "--depth" that has submodules and Git is not
fetching the necessary submodule commits:

Unable to checkout '$SHA' in submodule path 'path/to/submodule'

I tried to tackle that with [2] which would detect this case and
print the following error instead (slightly changed from the patch):

Unable to checkout '$SHA' in submodule path '/path/to/commit'.
Try to remove the '--depth' argument on clone!

[1] https://www.mail-archive.com/git%40vger.kernel.org/msg82614.html
[2] https://www.mail-archive.com/git%40vger.kernel.org/msg82613.html


> 
>> So to fetch the correct submodule commits, we need to
>> * traverse the superproject and list all submodule commits.
>> * fetch these submodule commits (C and E) by sha1
> 
> I do not think requiring that C to be fetched when the superproject
> is cloned with --depth=2 (hence A and B are present in the result)
> is a good definition of "correct submodule commits".  The initial
> clone could be "superproject follows --depth, all submodules are
> cloned with --depth=1 at the commits referenced by the superproject
> tree"--by that definition, you need E but you do not want C.
> 
> As a specification of the behaviour, the above two might work, but I
> do not think that should be the implementation.  In other words,
> "The implementation should behave as if it did the above two" is OK,
> and it is also OK to qualify with further conditions to help the
> implementation.  For example, the current structure assumes that E
> and C are reachable from "some" ref in submodule, so that at least a
> whole clone of the submodule would give them to you--otherwise you
> would not be able to even build the superproject at A or B.  Perhaps
> it is OK to further require that, when you are working in a single
> branch mode and working on 'master', you are required to have
> commits C and E reachable on the 'master' branch in the submodule,
> and that may lets you limit the need for such scanning of the
> history?
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
