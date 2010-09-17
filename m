From: Pat Notz <patnotz@gmail.com>
Subject: Re: [PATCH 1/2] commit: add message options for rebase --autosquash
Date: Fri, 17 Sep 2010 09:34:44 -0600
Message-ID: <AANLkTikZTSiG6anuRR0h499JeTzRcdeE-jaYMu7Gqr8W@mail.gmail.com>
References: <1284687596-236-1-git-send-email-patnotz@gmail.com>
 <1284687596-236-2-git-send-email-patnotz@gmail.com> <4C93288B.7000908@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Stephen Boyd <bebarino@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 17 17:35:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Owcy2-0007kO-8x
	for gcvg-git-2@lo.gmane.org; Fri, 17 Sep 2010 17:35:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755065Ab0IQPfH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 17 Sep 2010 11:35:07 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:55512 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754231Ab0IQPfF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 17 Sep 2010 11:35:05 -0400
Received: by eyb6 with SMTP id 6so1035466eyb.19
        for <git@vger.kernel.org>; Fri, 17 Sep 2010 08:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=JSemdyNPXnQo7UuCBhjyuhBQj8BvxyHxZjh+/HRRFZk=;
        b=fQewlQY5dUqDF9qKk/4S53eHLSHCMcVg6/ueZfjLGDHUFa7rNhw4lupeo/5VRoQdRV
         UtIGqxoVCQM474mOl7wEZukldACoSEgzl7v+QbRpD1I9g/HILPw/c0GWu0rpMhDd97+i
         t8jJU0lRQws7t3tol4MTiRUF0HSe5yLL8+acY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=GmwOanlO8g3QoaAf/e/xP8lFqwyuxTya1SSg6oTQK19V/dJRtpljFUPUzV90MAOVp+
         gxMsGGwWwegs6+7dPqLV6aHFCUcBhO6Ohz6rw3bwYjL0rqVb9e8QmS/hift9qp6y7iH5
         pjJYDQPfSivOTvVvwe6V5nH2ZpwkY26/9mUiI=
Received: by 10.239.160.2 with SMTP id a2mr288346hbd.84.1284737704149; Fri, 17
 Sep 2010 08:35:04 -0700 (PDT)
Received: by 10.239.185.65 with HTTP; Fri, 17 Sep 2010 08:34:44 -0700 (PDT)
In-Reply-To: <4C93288B.7000908@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156388>

On Fri, Sep 17, 2010 at 2:36 AM, Stephen Boyd <bebarino@gmail.com> wrot=
e:
> On 09/16/2010 06:39 PM, Pat Notz wrote:
>> These options make it convenient to construct commit messages for us=
e
>> with 'rebase --autosquash'. =A0The resulting commit message will be
>> "fixup! ..." or "squash! ..." where "..." is the subject line of the
>> specified commit message.
>>
>> Example usage:
>> =A0 $ git commit --fixup HEAD~2
>> =A0 $ git commit --squash HEAD~5
>>
>> Signed-off-by: Pat Notz <patnotz@gmail.com>
>> ---
>
> So far I've been using an alias for these, but I suppose making them
> real features of git could be worthwhile. What are the benefits with
> this approach vs. an alias?

Mainly it's convenience.  The rebase --autosquash feature seems too
hard to use without this or an alias and making everyone code their
own alias seems a lot to ask.

Still, I admit that I was concerned with adding yet another option to
git-commit.  If enough people object, I can live with that.

>> @@ -863,7 +871,7 @@ static int parse_and_validate_options(int argc, =
const char *argv[],
>> =A0 =A0 =A0 if (force_author && renew_authorship)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 die("Using both --reset-author and --aut=
hor does not make sense");
>>
>> - =A0 =A0 if (logfile || message.len || use_message)
>> + =A0 =A0 if (logfile || message.len || use_message || fixup_message=
 || squash_message)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 use_editor =3D 0;
>> =A0 =A0 =A0 if (edit_flag)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 use_editor =3D 1;
>
> The whole point of squash is to combine two commit texts, right?
> Otherwise wouldn't you use --fixup where you throw away the text
> eventually and thus don't want to open an editor?

Good point.  Admittedly, I was focusing on the 'fixup' case but squash
needs to open the editor with the first line pre-filled.

>
>> @@ -883,15 +891,19 @@ static int parse_and_validate_options(int argc=
, const char *argv[],
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 f++;
>> =A0 =A0 =A0 if (edit_message)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 f++;
>> + =A0 =A0 if (fixup_message)
>> + =A0 =A0 =A0 =A0 =A0 =A0 f++;
>> + =A0 =A0 if (squash_message)
>> + =A0 =A0 =A0 =A0 =A0 =A0 f++;
>> =A0 =A0 =A0 if (logfile)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 f++;
>> =A0 =A0 =A0 if (f > 1)
>> - =A0 =A0 =A0 =A0 =A0 =A0 die("Only one of -c/-C/-F can be used.");
>> + =A0 =A0 =A0 =A0 =A0 =A0 die("Only one of -c/-C/-F/--fixup/--squash=
 can be used.");
>> =A0 =A0 =A0 if (message.len && f > 0)
>> - =A0 =A0 =A0 =A0 =A0 =A0 die("Option -m cannot be combined with -c/=
-C/-F.");
>> + =A0 =A0 =A0 =A0 =A0 =A0 die("Option -m cannot be combined with -c/=
-C/-F/--fixup/--squash.");
>
>
> Furthering that point, perhaps I want to squash this commit into anot=
her
> commit using the commit text from yet another commit or just with an
> extra note from the command line (-m). Perhaps this is where the bene=
fit
> over an alias comes in?

That's a good use-case.  I'll re-work the --squash option.

>
>> =A0 =A0 =A0 if (edit_message)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 use_message =3D edit_message;
>> - =A0 =A0 if (amend && !use_message)
>> + =A0 =A0 if (amend && (!use_message && !fixup_message && !squash_me=
ssage))
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 use_message =3D "HEAD";
>> =A0 =A0 =A0 if (!use_message && renew_authorship)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 die("--reset-author can be used only wit=
h -C, -c or --amend.");
>> @@ -932,6 +944,23 @@ static int parse_and_validate_options(int argc,=
 const char *argv[],
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (enc !=3D utf8)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 free(enc);
>> =A0 =A0 =A0 }
>> + =A0 =A0 if (fixup_message || squash_message) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 unsigned char sha1[20];
>> + =A0 =A0 =A0 =A0 =A0 =A0 struct commit *commit;
>> + =A0 =A0 =A0 =A0 =A0 =A0 const char * target_message =3D fixup_mess=
age ? fixup_message : squash_message;
>> + =A0 =A0 =A0 =A0 =A0 =A0 const char * msg_fmt =3D fixup_message ? "=
fixup! %s" : "squash! %s";
>
> Style nit: stick the * to the variable.
>

Oops, thanks.

> I read this and became confused. fixup_message? target_message? Perha=
ps
> it should be renamed to fixup_commit, squash_commit, target_commit?
>

I was mostly trying to reduce duplicate code for the two cases... but,
I bet when I re-work --squash this will go away.

>> + =A0 =A0 =A0 =A0 =A0 =A0 struct strbuf buf =3D STRBUF_INIT;
>> + =A0 =A0 =A0 =A0 =A0 =A0 struct pretty_print_context ctx =3D {0};
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (get_sha1(target_message, sha1))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 die("could not lookup comm=
it %s", target_message);
>> + =A0 =A0 =A0 =A0 =A0 =A0 commit =3D lookup_commit_reference(sha1);
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (!commit || parse_commit(commit))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 die("could not parse commi=
t %s", target_message);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 format_commit_message(commit, msg_fmt, &bu=
f, &ctx);
>> + =A0 =A0 =A0 =A0 =A0 =A0 fixup_message_buffer =3D strbuf_detach(&bu=
f, NULL);
>> + =A0 =A0 }
>>
>
> Is it necessary to do this block of code here? Couldn't you lookup an=
d
> format the commit in prepare_to_commit()? Then we wouldn't have to
> allocate another strbuf and the "message" code would be more centrali=
zed.
>

Probably not, I was mostly trying to follow the example from the
use_message (-C/-c) feature.  It *would* be nice to avoid the extra
memory (de)alloc.

Thanks for the great feedback!
