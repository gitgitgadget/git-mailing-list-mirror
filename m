From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [BUG] redundant error message
Date: Fri, 6 Dec 2013 08:15:52 +0700
Message-ID: <CACsJy8CKDiCX0G3jD6KLZ=cyvp6zf4MT6DCY0XodfD8rkQF=wA@mail.gmail.com>
References: <CACsJy8BtCi_QSMZXfnscQmRyjvgSV1fG6smAOoCSab_e2YATxQ@mail.gmail.com>
 <20131205191518.GB19039@sigill.intra.peff.net> <xmqqsiu73w6n.fsf@gitster.dls.corp.google.com>
 <20131205200306.GA13443@sigill.intra.peff.net> <xmqqfvq73vhw.fsf@gitster.dls.corp.google.com>
 <20131205210000.GA19617@sigill.intra.peff.net> <20131205212851.GA21776@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Dec 06 02:16:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vok1s-0002BY-FJ
	for gcvg-git-2@plane.gmane.org; Fri, 06 Dec 2013 02:16:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751490Ab3LFBQY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Dec 2013 20:16:24 -0500
Received: from mail-qe0-f51.google.com ([209.85.128.51]:63617 "EHLO
	mail-qe0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750981Ab3LFBQX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Dec 2013 20:16:23 -0500
Received: by mail-qe0-f51.google.com with SMTP id 1so26336qee.38
        for <git@vger.kernel.org>; Thu, 05 Dec 2013 17:16:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=qBK+oyuUuc3oFxrJ6Q1Y7W0g7wrVR6WUJCnV5f4ZkNQ=;
        b=QoZZcaL0SCQD3Z6ULVbR10kv7EJTwdKUTXBKoqUT5MdkuZT0TIGAX+P/x6QPD1ZpMK
         c+6P7t81Ij/gLXDdW4jiWEL8mTI7gcmWDqQOcucTBMS7Jhe21sImHpr3cqXZPfQwFx6x
         43c+YdxIMQxV0l4R+4hSZ1eC6gmDWUgTt+vNLjK413KgoTuE/gJZHW0aytMnV1xPeuSg
         KaTIs+pw4J3eaZorF4F8iJ4WI2AVzMFU+hYNo+lt4wYiZytqmskq+6wLwUoKgrkqbowM
         5hfGvX3C7BqGXn/YUU3dwJcfQyKY+6OeKXtIgHbUhKHRE+19uzMcZZPCCC/n/YsAcfQz
         /beg==
X-Received: by 10.229.97.134 with SMTP id l6mr1257597qcn.11.1386292582993;
 Thu, 05 Dec 2013 17:16:22 -0800 (PST)
Received: by 10.96.124.101 with HTTP; Thu, 5 Dec 2013 17:15:52 -0800 (PST)
In-Reply-To: <20131205212851.GA21776@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238921>

On Fri, Dec 6, 2013 at 4:28 AM, Jeff King <peff@peff.net> wrote:
> BTW, the raw looping to find "--" made me wonder how we handle:
>
>   git log --grep -- HEAD
>
> I'd expect it to be equivalent to:
>
>   git log --grep=-- HEAD
>
> but it's not; we truncate the arguments and complain that --grep is
> missing its argument. Which is probably good enough, given that the
> alternative is doing a pass that understands all of the options. But it
> does mean that the "--long-opt=arg" form is safer than the split form if
> you are passing along an arbitrary "arg".

Maybe we could make setup_revisions() use parse_options() someday,
which understands about arguments and dashdash.

$ ./git grep -e -- foo
fatal: ambiguous argument 'foo': both revision and filename
Use '--' to separate paths from revisions, like this:
'git <command> [<revision>...] -- [<file>...]'
$ ./git grep -e -- -- foo
$
-- 
Duy
