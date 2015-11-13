From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v2] add test to demonstrate that shallow recursive clones fail
Date: Fri, 13 Nov 2015 15:16:01 -0800
Message-ID: <CAGZ79kYDKM2ffdiR-+wQ9=HTgCZMG3UstJiNVrSh7rB1p9xecA@mail.gmail.com>
References: <1447321061-74381-1-git-send-email-larsxschneider@gmail.com>
	<20151113053547.GD29708@sigill.intra.peff.net>
	<CAGZ79kbWS=fc-18F=Omv7g4wqgrx4SB=iZHHUC=6ELUYDCWBMA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Lars Schneider <larsxschneider@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Duy Nguyen <pclouds@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Nov 14 00:16:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZxNZi-0002aw-7M
	for gcvg-git-2@plane.gmane.org; Sat, 14 Nov 2015 00:16:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752567AbbKMXQE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Nov 2015 18:16:04 -0500
Received: from mail-yk0-f174.google.com ([209.85.160.174]:36796 "EHLO
	mail-yk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752174AbbKMXQB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Nov 2015 18:16:01 -0500
Received: by ykdr82 with SMTP id r82so172964434ykd.3
        for <git@vger.kernel.org>; Fri, 13 Nov 2015 15:16:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=oKysoyrCEP1bS3fLquk4XvufIZdSxazfa5utgLWerfQ=;
        b=P1OCHRbB8Qjvy5PSc7YQZCfjeyYoLTtPWOZKuUyhBGMWvqz7EFuVR5M1GVehrxitjH
         WRMXQprGBAaF/N5RJJw2/yEEJKe25eRhz1lNENxFNxRwvtHHQN6TvLmctIiyN0cAB9Q/
         lhrDDTyw6rtfRbPe8V1TH9cQh9WmzypM3+zpW82vmDhwQ8+Cex5aHYJ0ZW+jcHjy5QU3
         B0JP7oaY69rRXGAHaw113LUcF7NLzMp2Vo60UGkeHolKLGo6gJY1Hjmuwa8MHYCaurt5
         BWVllxBwc/k54thEh3H4lqKGDu+HdWPhEHvhWDHryAi8CsiBfepJemBYSdeuc5kWuFuJ
         9WdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=oKysoyrCEP1bS3fLquk4XvufIZdSxazfa5utgLWerfQ=;
        b=KZGgZJXwKM8xrU2tTHNue6k/dSQdQcMvpK+P/PrTKPlPFIef61wJFcPN2i1VG+6M9g
         ExBwhaeZwJKAYgE3LlrVGLNFXfP1jCxHZ3B0/yI14RXkYGbEGefrLnz52ShXJn0snJAg
         a/L9FWdAJ62thpbbPJzXNx17VnB89OJ0k32InpsW8E+JJTYWGKF9swbvjvhmKzWvwjIy
         awvrmrk3jpc3xCUb8mifcue0dGgwt7U/+XdmQSQ8rzh1BA/F4tOwZzDOtsbvB4GmbxXx
         cUE20RMNuqBGfa2M5uwA/9hf0XIBK/GBtdWtsf5w7Gnoqf3nolFZqTqyZHZWjjmoCXEj
         R9dw==
X-Gm-Message-State: ALoCoQn3P2NRmKt+qcB+D0+DPhHAXEVuwFjO/mxCr2SAJddMIfH+rvWHuRKG/isag4oySy2W9zTi
X-Received: by 10.13.214.19 with SMTP id y19mr25090323ywd.63.1447456561083;
 Fri, 13 Nov 2015 15:16:01 -0800 (PST)
Received: by 10.37.196.70 with HTTP; Fri, 13 Nov 2015 15:16:01 -0800 (PST)
In-Reply-To: <CAGZ79kbWS=fc-18F=Omv7g4wqgrx4SB=iZHHUC=6ELUYDCWBMA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281271>

On Fri, Nov 13, 2015 at 10:41 AM, Stefan Beller <sbeller@google.com> wrote:
> On Thu, Nov 12, 2015 at 9:35 PM, Jeff King <peff@peff.net> wrote:
>>
>> Hrm. Do we want to make these workarounds work correctly? Or is the
>> final solution going to be that the first command you gave simply works,
>> and no workarounds are needed.  If the latter, I wonder if we want to be
>> adding tests for the workarounds in the first place.
>
> I think we want to make the final solution just work. I dug into that and it is
> harder than expected. I may even call it a bug. The bug doesn't occur often as
> it is only triggered by things like rewriting history (forced pushes)
> or a short dpeth
> argument.
>
> So if you invoke "git clone --recursive", it will internally just
> delegate the submodule
> handling to "git submodule update --init --recursive", which then (as
> the submodule
> doesn't exist yet) will delegate the cloning to "git submodule--helper
> clone", which
> will then call git clone for the actual cloning.
>
> However in this whole chain of commands we never pass around the actual sha1
> we need. The strategy is to clone first and then checkout the sha1, which the
> superprojects wants to see. The desired sha1 was hopefully included in
> the cloning,
> so we can check it out.
>
> But the sha1 may not be present if we have a very short depth argument, or if we
> rewrote history. In case of a short depth argument, consider the
> following history:
>
> ... <- A <- B
>
> A is the recorded sha1 in the superproject, whereas B is the HEAD in the
> remote you're cloning from. If cloning with depth=1, the most naive way
> would have been to pass on the depth argument down the command chain,
> but then we would end up cloning B with no further depth, and upon checkout
> we cannot find A.
>
> In case of the rewritten history, consider:
>
> .. < - C <- B
>          \
>           A
>
> whereas A is the recorded sha1 in the superproject, but on a different branch
> (or even just a dangling commit. but used to be on master).
> B is the master branch. In case we pass on --depth to cloning the submodule,
> --single-branch is implied by --depth, so we would not clone A. In case of
> A being a dangling commit, we wouldn't even clone it without the depth argument.
>
> So I propose:
>  * similar to fetch, we enable clone to obtain a specific sha1 from remote.
>  * we explicitly pass the submodule sha1 as recorded in the superproject
>    to the submodule fetch/clone in case we follow the exact sha1. In case of
>    --remote or the branch field present in the superprojects .gitmodule file,
>    we can just pass the branch name.
>
> Thanks,
> Stefan

+cc Junio, Duy

So cloning from an arbitrary SHA1 is not a new thing I just came up with,
but has been discussed before[1].

Junio wrote on Oct 09, 2014:
> This is so non-standard a thing to do that I doubt it is worth
> supporting with "git clone".  "git clone --branch", which is about
"> I want to follow that particular branch", would not mesh well with
> "I want to see the history that leads to this exact commit", either.
> You would not know which branch(es) is that exact commit is on in
> the first place.

I disagree with this. This is the *exact* thing you actually want to do when
dealing with submodules. When fetching/cloning for a submodule, you want
to obtain the exact sha1, instead of a branch (which happens to be supported
too, but is not the original use case with submodules.)

> The "uploadpack.allowtipsha1inwant" is a wrong configuration to tie
> this into.  The intent of the configuration is to allow *ONLY*
> commits at the tip of the (possibly hidden) refs to be asked for.
> Those who want to hide some refs using "uploadpack.hiderefs" may
> want to enable "allowtipsha1inwant" to allow the tips of the hidden
> refs while still disallowing a request to fetch any random reachable
> commit not at the tip.

If the server contains at least one superproject/submodule, there is a legit
use case for fetching an exact sha1, which isn't a tip of a branch, but may
be in any branch  or even in no branch at all. So I wonder how we want
to add that as a non-hacky solution to allow for fetching specific sha1s
as we still need to differentiate between obligerated (forced pushed,
"go away sha1s") and legit submodule pointer sha1s.

As we don't want to lookup in a superproject (we don't even know
which superproject we'd need to look into), we can either go for a
more liberal sha1 fetching attitude or somehow modify the submodule
repository to mark sha1s which are good to fetch as "submodule update"
fetches.

Proposal:
    Could we have a refs/submodules/tracking which is tracking all the
    sha1s a superproject ever pointed to? That ref would need to be
    maintained by the superproject. If there is a forced push to the
    superproject, it would also need to obliterate some of the history
    in that special ref.
Problems with this proposal:
    How do we care about multiple superprojects,
    or superprojects with different branches?

[1] http://git.661346.n2.nabble.com/Can-I-fetch-an-arbitrary-commit-by-sha1-td7619396.html
