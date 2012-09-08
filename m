From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: checkout extra files
Date: Sat, 8 Sep 2012 21:40:20 +0100
Organization: OPDS
Message-ID: <3DA7C9D97E19414C81F8D73CB66171DA@PhilipOakley>
References: <CAB9Jk9BvQmFfTq3a+e-7t-66s06jLK4fWuZB+MJHrAtbznBvHw@mail.gmail.com> <CACsJy8A6-Ok34QDqgSVavFDBE81UdcK4rLzkHe7P7UO=fXptGw@mail.gmail.com> <7vsjayew50.fsf@alter.siamese.dyndns.org> <CACsJy8BDtV95QmWmJ8CEh06FUePOB7KY6nKPR1KCZ7DkMN_MNQ@mail.gmail.com> <7vd322ebsz.fsf@alter.siamese.dyndns.org> <CAB9Jk9BbOJgVNepFittD5fVkFLY24Tf10PVg3MD6E1M3hMyNsQ@mail.gmail.com> <7vpq61dfn9.fsf@alter.siamese.dyndns.org> <7v8vcpdat2.fsf@alter.siamese.dyndns.org> <7vk3w5woc4.fsf@alter.siamese.dyndns.org>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>, <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>,
	"Angelo Borsotti" <angelo.borsotti@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 08 22:40:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TARpF-0000Lb-JX
	for gcvg-git-2@plane.gmane.org; Sat, 08 Sep 2012 22:40:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754838Ab2IHUkN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Sep 2012 16:40:13 -0400
Received: from out1.ip03ir2.opaltelecom.net ([62.24.128.239]:20089 "EHLO
	out1.ip03ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754741Ab2IHUkL (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 8 Sep 2012 16:40:11 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AuAKACisS1BZ8rU+/2dsb2JhbABFi0avAwKBB4EIghsFAQEFCAEBLh4BASELAgMFAgEDFQELJRQBBBoGBxcGARIIAgECAwGIA7olixOBWIN+YAOIHoVDmBmCZw
X-IronPort-AV: E=Sophos;i="4.80,392,1344207600"; 
   d="scan'208";a="398071632"
Received: from host-89-242-181-62.as13285.net (HELO PhilipOakley) ([89.242.181.62])
  by out1.ip03ir2.opaltelecom.net with SMTP; 08 Sep 2012 21:40:08 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205033>

From: "Junio C Hamano" <gitster@pobox.com>
Sent: Friday, September 07, 2012 9:49 PM
> Junio C Hamano <gitster@pobox.com> writes:
>
>> But that is not what is happening at all.  What goes on is far
>> simpler than that.
>>
>>  - the shell sees '*', matches it against working tree files, to
>>    obtain "f1" and "f2";
>>
>>  - the shell tells "git" to "checkout e6f935e -- f1 f2";
>>
>>  - "git" looks into the tree of e6f935e to find paths that match
>>    "f1" and "f2".
>>
>> When "git" is run by the shell in the last step, it has _no_ clue
>> that the end user typed "*" from the shell.  It only sees "f1" and
>> "f2" on the command line.  There is no "set T" to be intersected
>> with "set W", so stop thinking in those terms, and you will be fine.
>>
>> Now the question is, _you_ will be fine, but can the documentation
>> be updated in such a way so that it will help _others_ to also stop
>> thinking about "intersection between set W and set T"?  I do not
>> have a good answer to that.
>
> Let's do this.  I do not want a shell tutorial in "git checkout"
> documentation, but this would fit better in the documentation for
> the CLI convention.

The difficulty with putting it in gitcli is that it is referenced from 
almost nowhere, so won't provide help to the user.

Having said that, it would therefore be better to point folk at gitcli 
in a few more places, not just the 'see also' line at the very end of 
the general 'git' page, and buried within rev-parse.

>
> -- >8 --
> gitcli: contrast wildcard given to shell and to git
>
> People who are not used to working with shell may intellectually
> understand how the command line argument is massaged by the shell
> but still have a hard time visualizing the difference between
> letting the shell expand fileglobs and having Git see the fileglob
> to use as a pathspec.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
> Documentation/gitcli.txt | 16 ++++++++++++++++
> 1 file changed, 16 insertions(+)
>
> diff --git c/Documentation/gitcli.txt w/Documentation/gitcli.txt
> index ea17f7a..220621b 100644
> --- c/Documentation/gitcli.txt
> +++ w/Documentation/gitcli.txt
> @@ -38,6 +38,22 @@ arguments.  Here are the rules:
>    you have to say either `git diff HEAD --` or `git diff -- HEAD` to
>    disambiguate.
>
> + * Many commands allow wildcards in paths, but you need to protect
> +them from getting globbed by the shell.  These two mean different 
> things:
> ++
> +--------------------------------
> +$ git checkout -- *.c
> +$ git checkout -- \*.c
> +--------------------------------
> ++
> +The former lets your shell expand the fileglob, and you are asking
> +the dot-C files in your working tree to be overwritten with the 
> version
> +in the index.  The latter passes the `*.c` to Git, and you are asking
> +the paths in the index that match the pattern to be checked out to 
> your
> +working tree.  After running `git add hello.c; rm hello.c`, you will 
> _not_
> +see `hello.c` in your working tree with the former, but with the 
> latter
> +you will.
> +
> When writing a script that is expected to handle random user-input, it 
> is
> a good practice to make it explicit which arguments are which by 
> placing
> disambiguating `--` at appropriate places.
