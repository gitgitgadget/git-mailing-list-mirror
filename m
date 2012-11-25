From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Python extension commands in git - request for policy change
Date: Sun, 25 Nov 2012 12:40:24 +0100
Message-ID: <CAMP44s0WYiV3hTE7u28_Wd59FkGfu3o_psS0gocpnibzN4--Fg@mail.gmail.com>
References: <20121125024451.1ADD14065F@snark.thyrsus.com>
	<CAMP44s18MzmWRNRiRjL6hvpK1cm=S-97fB2ep-_0RAhnfs5cvA@mail.gmail.com>
	<50B1F684.5020805@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "Eric S. Raymond" <esr@thyrsus.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Sun Nov 25 12:40:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TcaZp-0008F5-Ki
	for gcvg-git-2@plane.gmane.org; Sun, 25 Nov 2012 12:40:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753136Ab2KYLk0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Nov 2012 06:40:26 -0500
Received: from mail-ob0-f174.google.com ([209.85.214.174]:57869 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753069Ab2KYLkZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Nov 2012 06:40:25 -0500
Received: by mail-ob0-f174.google.com with SMTP id wc20so10029230obb.19
        for <git@vger.kernel.org>; Sun, 25 Nov 2012 03:40:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=58ev8wd8V15zHSAmrQ3i0cuXbBL0S/MGf0wMDXJn6hk=;
        b=nf6PhVZAqh804Hlmw1jbxcDXXcUASvvOmqKZNQEVjoUb2G2NJ7dsPKzSKeliP3kUuF
         rht+drakZEj5JRaSQFQhPU+NfBlR4+YkukNh042svG2JOIdNzheXI4TDIp5pLPnT+Bt+
         UhWBMe5PPELu9oQ6meutCiSNuv9H0uL/YunV+bs9BQ3NwIqnbkDvKXdYC7pFkyJJCwHy
         mPSGYDeE6q+AsKMeF7gDlipnsZhazENXQIOvRE6PeSTZp1tj3GkmcFa3UFqmft1M+lt9
         nsqzQcWcnaqke8fQpC5mzgNrqrsq5zztZ6lnI1slYG7ANjR5N/yQGtJxtpnSy6x/cQk6
         dtgQ==
Received: by 10.182.21.135 with SMTP id v7mr6921699obe.101.1353843625057; Sun,
 25 Nov 2012 03:40:25 -0800 (PST)
Received: by 10.60.32.196 with HTTP; Sun, 25 Nov 2012 03:40:24 -0800 (PST)
In-Reply-To: <50B1F684.5020805@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210365>

On Sun, Nov 25, 2012 at 11:44 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> On 11/25/2012 09:53 AM, Felipe Contreras wrote:
>> On Sun, Nov 25, 2012 at 3:44 AM, Eric S. Raymond <esr@thyrsus.com> wrote:
>>> 1) In 2012, we can specify a "floor" Python version of 2.6 (shipped in
>>> 2008) and be pretty much guaranteed it will be anywhere we want to
>>> deploy except Windows.  Windows will remain a problem because Python
>>> isn't part of the stock install, but that's an equal or worse problem
>>> for shell and Perl - and at least the Python project ships a binary
>>> installer for Windows.
>>
>> What if my extension only supports python 2.7? Or what if my extension
>> wants to support 2.0?
>
> There would obviously have to be a policy like "all Python code in core
> git must run on any Python interpreter with 2.6 <= version < 3.0", just
> as there are policies about what C and shell features are allowed.  If
> you happen to want to support earlier versions of Python, I don't see
> why anybody would stop you as long as your code also runs in the
> mandated versions.

Of course, but there are experts in C and shell around, not so many
python experts. So if somebody sneaks in a python program that makes
use of features specific to python 2.7, I doubt anybody would notice.
And if they did, I doubt that would be reason enough for rejection,
supposing that porting to 2.6 would be difficult enough.

Anyway, I think this is all guesswork.

> Of course Perl will have the same problem if Perl6 ever materializes.

It *might*, it might not be as severe.

>>> 2) Python extension commands should test the Python version on startup
>>> and die loudly but gracefully in the rare case that they don't find
>>> what they need.
>>
>> Yes, they should _if_ they know what version they need. In my
>> extensions I really have no idea.
>
> Then simply (with the help of the mailing list) ensure that your
> extensions run under 2.6 (or whatever the chosen minimum version is) and
> everything will be OK.  It is not an error to specify 2.6 as the minimum
> version even though your script happens also to run on older versions :-)

Who would do that? I don't see a lot of people.

>>> 3) We should be unconditionally be encouraging extensions to move
>>> from shell and Perl to Python.  This would be a clear net gain is
>>> portability and maintainability.
>>
>> NO! It's up to the developer to choose what language to use, and I
>> find it very chauvinist of you to say "python is better, so let's all
>> use python". So far you have listed a few advantages of python, but
>> you haven't explained so far what is wrong with shell and perl.
>
> Given that some languages are accepted in git-core and others are not,
> it's already not "up to the developer to choose what language to use".
> At best there is a short list of "blessed" languages, and the developer
> can choose among only those.

They are not because they haven't been proposed. Things change.

>> In fact, while advancing python you have made clear a problem with
>> python; the version requirements. So far I have *never* encountered a
>> problem with git because of my bash version, or my perl version. And
>> we haven't touched to the python3 mess yet. To me, those are
>> advantages of shell and perl.
>
> On the contrary, there is *constant* traffic on the mailing list about
> incompatibilities between different shell implementations (sh, dash,
> bash, etc), not to mention those in other utilities (sed, grep, etc)
> that one is forced to work with in shell scripts.  Compatibility is a
> *huge* pain when developing shell code for git.  The fact that users
> typically don't encounter such problems is due to the hard work of POSIX
> lawyers on the mailing list correcting the compatibility errors of
> mortal programmers.

*Theoretical* incompatibilities on probably obscure systems. *I* have
never seen such compatibility issues *in practice*.

>> Actually, I don't care if 'git foo' is written in perl, or shell, or
>> c; as long as it *works*. And I would hate it if 'git rebase' ever
>> told me that I need a newer version of python, or worst; that I don't
>> have python in my system (Arch Linux ships 'python2', not 'python').
>
> The configure script would locate the correct interpreter and the build
> would adjust the scripts' shebang lines, just as things are tweaked
> within Perl scripts at build time.

Arch Linux doesn't use no configure script. And what if I'm building
git myself (I've hit the issue multiple times)? Perl might have
similar issues on other systems, but not on Arch Linux; /usr/bin/perl
is there.

>>> 4) We should be encouraging C code to move to Python, too.  There's
>>> little gain in portability on this path because modern C has cleaned
>>> up its act a lot, but the drop in expected bug loads would be well
>>> worth the porting effort.  Segfaults are not your friend, and the x2 to
>>> x5 drop in line count would do very good things for long-term
>>> maintainability.
>>
>> Definitely NO! I really really doubt git in python would be able to
>> achieve the same performance as git in c, but to show me wrong, it
>> wouldn't be very difficult to run a few measurements with python
>> dulwich *if* we are even to begin considering this point.
>>
>> And are segmentation faults really that different from python's
>> exceptions? Not to the user.
>
> There is one huge difference: it C it is all too easy to write code that
> leads to a security hole due to buffer overflows and other memory
> management errors.  Code written in a scripting language are largely
> immune to such problems (except of course for any such bugs in the
> interpreter itself, but the testing of the interpreter is shared across
> many projects and users).
>
> It would be insane to rewrite performance-critical C code in any
> scripting language, but there is a huge penumbra of code that is not
> performance critical and that mutates rapidly.  Such code is much easier
> to write and maintain in a sane scripting language if the portability
> issues can be mastered.

I think git developers are perfectly able to write such a code.

> The most important issues to consider when imagining a future with a
> hybrid of code in C and some scripting language "X" are:
>
> * Portability: is "X" available on all platforms targeted by git, in
>   usable and mutually-compatible versions?
>
> * Startup time: Is the time to start the "X" interpreter prohibitive?
>   (On my computer, "python -c pass", which starts the Python
>   interpreter and does nothing, takes about 24ms.)  This overhead would
>   be incurred by every command that is not pure C.

Agree.

> * Should the scripting language access the C functionality only by
>   calling pure-C executables or by dynamically or statically linking to
>   a binary module interface?  If the former, then the granularity of
>   interactions between "X" and C is necessarily coarse, and "X" cannot
>   be used to implement anything but the outermost layer of
>   functionality.  If the latter, then the way would be clear to
>   implement much more of git in "X" (and lua would also be worth
>   considering).

I think this is very far fetched at the moment. Proposals such as
libgit2 are moving things forward, but we are pretty far from a goal
like that.

> * Learning curve for developers: how difficult is it for a typical git
>   developer to become conversant with "X", considering both (1) how
>   likely is it that the typical git developer already knows "X" and
>   (2) how straightforward and predictable is the language "X"?
>   In this category I think that Python has a huge advantage over
>   Perl, though certainly opinions will differ and Ruby would also be
>   a contender.

Right, but I have the feeling that most git developers are perfectly
familiar with C already. In order to move to something else, and all
the necessary burden of learning, or becoming more familiar with X, a
compelling argument must be put forward, and I haven't seen such an
argument.

> Personally, I regret wasting my time programming pointer arithmetic in
> git modules that are not performance-critical (and correcting bugs by
> others in these areas).  And I'm tired of having an idea to improve a
> git feature only to find that it is implemented in shell, where not even
> arrays are available.  I would therefore welcome more friendliness
> towards a decent scripting language in the git project.

Me too, if ruby was one of them.

Cheers.

-- 
Felipe Contreras
