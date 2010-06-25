From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [WIP PATCH 1/7] Add skeleton RA svnclient
Date: Fri, 25 Jun 2010 13:07:17 +0200
Message-ID: <AANLkTimirObq-HBrB4rQdAprN8mfd92rfFKSegJKwMsc@mail.gmail.com>
References: <1277310140-16891-1-git-send-email-artagnon@gmail.com> 
	<1277310140-16891-2-git-send-email-artagnon@gmail.com> <20100625001427.GA4683@burratino> 
	<alpine.561.2.00.1006251156180.2064@daniel2.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	David Michael Barr <david.barr@cordelta.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Daniel Shahaf <d.s@daniel.shahaf.name>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 25 13:07:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OS6l8-0002i4-Ld
	for gcvg-git-2@lo.gmane.org; Fri, 25 Jun 2010 13:07:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754493Ab0FYLHk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 25 Jun 2010 07:07:40 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:45482 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751813Ab0FYLHj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 25 Jun 2010 07:07:39 -0400
Received: by vws9 with SMTP id 9so3750923vws.19
        for <git@vger.kernel.org>; Fri, 25 Jun 2010 04:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=zz/6dx+n4MZoTCBFmRXdOv1Npcj4Jd0VIaqub/QzGAw=;
        b=RqLi9yTd04IdyvuhliKvNgvJh1KASnK7aB4kmyn/0j157Ko4jQr5mH0mInKJm0oSoV
         0XpF5GPu0XV+rA8OzWBP9mRqWYLnRDj4plJH/SgsEaQ6oHP0KI4Xl0bNITkNAFwQz94F
         3scrkv/PnWmPM2PmOUecllEMhu4f/SByrN3T8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=PlS9uBV1nLWT6wuulUKf+16PjZ1eniuOUQ0CcrOjMzlOjIYrcyzX71uiT4fdlQ1mR0
         BTcMDehuTesv4Fc4LS29+DYMbNGEqZSiYHXsZJzoe6geH3x8q0aHcVbpQUlIzNErSSCZ
         8ogldM0IuLyzU+VmcV2bOwKcPkF5mQ+jmNDIs=
Received: by 10.229.186.193 with SMTP id ct1mr298928qcb.295.1277464057604; 
	Fri, 25 Jun 2010 04:07:37 -0700 (PDT)
Received: by 10.229.45.71 with HTTP; Fri, 25 Jun 2010 04:07:17 -0700 (PDT)
In-Reply-To: <alpine.561.2.00.1006251156180.2064@daniel2.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149678>

Hi Jonathan and Daniel,

Jonathan: First, thanks for bringing up these questions- they will
definitely help future reviewers. I'll now sprinkle Daniel's replies
with a few of my observations.
Daniel: Thanks for responding to the questions- your insights as a
core Subversion developer are most appreciated. I'll add a few notes
to your answers now.

Daniel Shahaf wrote:
> Jonathan Nieder wrote on Fri, 25 Jun 2010 at 03:14 -0000:
>> For now, just some na=C3=AFve questions. =C2=A0Warning: I know nothi=
ng about
>> svn internals.

That's alright. I highly encourage na=C3=AFve questions- I'm new to SVN
myself. I also highly recommend reading the API documentation and
going through the code for answers to "why is it like THIS" questions
as I haven't manged to clean out the Subversion style yet. Hopefully,
I'll have some good notes that I can attach with my next series to put
in the trunk.

>> I assume this corresponds to the ra-svn branch of
>> <http://github.com/artagnon/svn-dump-fast-export.git>. =C2=A0Has the
>> relevant code changed much since you sent it?

Yes. I've managed to fix the deltified dump, and have now started
working on a full text dump. Due to my low familiarity with the libsvn
API, the cleanups are mixed with my code in the history; it needs a
thorough line-by-line scrubbing.

>> What is a baton?
>>
>
> The context object for a callback.
>
> You call:
>
> =C2=A0 =C2=A0some_function(your_callback_function, your_baton)
>
> which then calls:
>
> =C2=A0 =C2=A0your_callback_function(your_baton, other_arguments)

In general, I've found that batons are void * objects in which you can
stuff anything you like and pass around from function to function:
I've abused them quite heavily in my code by stuffing all kinds of
things into them: see fb->eb->* in my current code for an example of
this.

>> [...]
>> > + =C2=A0void *wrapped_edit_baton;
>> [...]
>> > + =C2=A0void *edit_baton;
>> > + =C2=A0void *wrapped_dir_baton;
>> [...]
>> > + =C2=A0void *edit_baton;
>> > + =C2=A0void *wrapped_file_baton;
>>
>> Are these opaque types necessary?
>>
>
> The convention in Subversion's code is to convert the void * to
> a concrete_baton_t * only inside the callback. =C2=A0If you wish to d=
eclare
> these, e.g., as
>
> =C2=A0 =C2=A0debug_editor_baton_t *wrapped_baton;
>
> You can probably do that too.

The function prototypes in libsvn contain void * parameters
corresponding to batons, so I'd have to typecast explicitly to avoid
any warnings. I think Jonathan's also referring to the absence of the
"struct" keyword everywhere, as that is against Git policy.
Unfortunately, everything is typedef'ed in libsvn, and we cannot do
much about that.

>> What does this do? =C2=A0Is SVN_ERR for debugging?
>
> That's how we implement exception throwing in C. =C2=A0SVN_ERR means =
"if this
> returned a non-NULL svn_error_t *, then return that error to our
> caller".
>
> The other pattern does
>
> =C2=A0 =C2=A0svn_error_t *err =3D svn_stream_printf();
>
> and then inspects err and err->apr_err to decide whether to ignore th=
e
> error or return it (possibly wrapped).

>> Where does the output go?
>>
>
> SVN_ERR does not print anything. =C2=A0It may return(), though.

Embarrassingly enough, write_indent does exactly what it says it does:
It writes some spaces (or indent) to eb->out, which you'll find is
actually stderr in svn_delta__get_debug. In the cleanup, I should
probably get rid of this. As far as the error handling is concerned,
to be terse, SVN_ERR and SVN_INT_ERR are cpp macros. They are defined
as follows in svn_error.h (with line numbers from the trunk file).
Note however, that even with all this error handling, the most common
type of error I get by far is the segfault: I'll make an effort to
document the pitfalls.

00284 #define SVN_ERR(expr)                           \
00285   do {                                          \
00286     svn_error_t *svn_err__temp =3D (expr);        \
00287     if (svn_err__temp)                          \
00288       return svn_error_return(svn_err__temp);   \
00289   } while (0)

00336 #define SVN_INT_ERR(expr)                                        =
\
00337   do {                                                           =
\
00338     svn_error_t *svn_err__temp =3D (expr);                       =
  \
00339     if (svn_err__temp) {                                         =
\
00340       svn_handle_error2(svn_err__temp, stderr, FALSE, "svn: ");  =
\
00341       svn_error_clear(svn_err__temp);                            =
\
00342       return EXIT_FAILURE; }                                     =
\
00343   } while (0)

>> I take it these are callbacks? =C2=A0Is there overview documentation=
 for
>> them somewhere?
>>
>
> svn_delta_editor_t in
> http://svn.apache.org/repos/asf/subversion/trunk/subversion/include/s=
vn_delta.h

Yes, they are callbacks that are fired automatically by the editor. In
svn_delta.h, look at struct svn_delta_editor_t (and the corresponding
doxygen-style comments).

>> I take it that the fields of svn_delta_editor_t do not have a
>> well-defined order? =C2=A0Ugh.

No, they don't. I've tried to stick to the order in the struct
svn_delta_editor_t.

>> In any case, I suspect this would be easier to read rearranged a lit=
tle:
>>
>> =C2=A01. declarations for callbacks
>> =C2=A02. get_debug_editor implementation
>> =C2=A03. definitions of types not needed in get_debug_editor()
>> =C2=A04. implementations of callbacks
>>
>> That way, a person reading straight through can figure out what=E2=80=
=99s
>> going on a little earlier.

Agreed. I'm still struggling to clean up the Subversion-style code. We
can probably discuss this at length on IRC?

>> What is svn_cmdline_init?
>
> A Subversion API that does some necessary initializations (e.g., call=
s
> apr_initialize()). =C2=A0See subversion/include/svn_cmdline.h for doc=
s
> (and subversion/libsvn_subr/cmdline.c for the implementation).

These svn_cmdline functions are actually shortcuts- they do all the
initializations required for a "typical" command line SVN client. It
saves me the trouble of having to figure out what I missed
initializing: I'll be using more of them in future; to eliminate the
auth baton creation by hand, for example.

>> Is this code destined for inclusion in svn upstream, and if so, wher=
e
>> can one find the surrounding code this should fit in with?

Yes, but with a lot of style transformations. In svnsync/main.c.
Atleast that's the plan, as per the discussion on #svn-dev

-- Ram
