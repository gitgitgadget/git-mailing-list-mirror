From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [PATCH] send-email: add --confirm option
Date: Sun, 1 Mar 2009 09:05:12 -0500
Message-ID: <76718490903010605o2083ba24oda781fb7053c4321@mail.gmail.com>
References: <1235895801-80414-1-git-send-email-jaysoffian@gmail.com>
	 <7vhc2d8vjk.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Nanako Shiraishi <nanako3@lavabit.com>,
	Paul Gortmaker <paul.gortmaker@windriver.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 01 15:07:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LdmJj-00081W-3E
	for gcvg-git-2@gmane.org; Sun, 01 Mar 2009 15:06:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753404AbZCAOFR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 1 Mar 2009 09:05:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753263AbZCAOFQ
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Mar 2009 09:05:16 -0500
Received: from rv-out-0506.google.com ([209.85.198.230]:19104 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752906AbZCAOFO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 1 Mar 2009 09:05:14 -0500
Received: by rv-out-0506.google.com with SMTP id g37so1874733rvb.1
        for <git@vger.kernel.org>; Sun, 01 Mar 2009 06:05:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=+k+8qCH5F50RZ1eIn44QLHlyMJTqrTXhM7nWbU5RMs8=;
        b=IZJ3Ev5YnYURgdUEatjv13oZAHFeOkSOGnC02Hemr7LiVI7w+rVKFOXkEtFPKog7Q4
         aLzsjrT5b88TymUP2yMcZpdPfFimmrkg+JjKbr2bMgHxtzpRwB//6rmKSuQT2QY9JZq1
         tFjB2ExCCSJc/fgo0wHDDMLvNjueIJzKy3WOk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=w4PlJ2/PnQpFjF7bfVOxBWsNM8Fx6RjhGu+g89yjsIE5J2cjrWmQvky+MfUTL4jXbV
         3xOHsqOIGL3mx5FS/cgjui57Po7vwV+7j9Y57sG1e2RO6pCG+L3ynVdZBEMpICt+T+iJ
         hPD6v/rONOpuxpX8zKxJytdgP/TONHG5OzLck=
Received: by 10.141.179.5 with SMTP id g5mr2391404rvp.76.1235916312396; Sun, 
	01 Mar 2009 06:05:12 -0800 (PST)
In-Reply-To: <7vhc2d8vjk.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111844>

On Sun, Mar 1, 2009 at 4:03 AM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> It is hard to judge if this is a good thing to do _at this point_. =C2=
=A0Those
> who complained may welcome it but that is hardly the point. =C2=A0You=
 need to
> convince those who stayed silent (because they thought the default wo=
n't
> change and were not paying attention) that it is a good change.

No, I won't. This is not my itch, I don't know who those users are,
and I think I provided any such users several easy ways out:

1) They can type "a" after the first prompt.
2) They can git config --global sendemail.confirm never
3) They won't even notice if they're using any suppresscc option, such
as yourself.

I know you're sensitive to existing users after getting burned by the
dashless-git issue, but I think you're over applying that lesson in
*this* case.

> Especially the changes (not additions) to existing tests worries me; =
each
> change to the existing one is a demonstration of breaking existing us=
ers.

There were two classes of changes:

1) Many of the tests Cc'd w/o warning. Those now prompt. Hence the
"git config sendemail.suppress never" at the top.

2) Since I added (1), the "echo y |" in the other tests was redundant.
I believe had a no-confirm option been available in the past, that the
test authors would not have used "echo y". And I thought it confusing
to leave the "echo y|" as someone might ask "if it's not supposed to
confirm, why is there an echo y here?"

> You cannot retrofit safety by disallowing things once you used to all=
ow,
> without upsetting existing users.

And you hamper your ability to improve the product by not allowing
even minor backward incompatible changes.

But I anticipated this objection and I thought very much about how an
existing user might hypothetically be upset, while accommodating the
very real concern of a new user.

Aside, when I upgrade a product, I expect it to change in some ways.
If I really don't want change, I don't upgrade.

On balance, I think this change will be silently appreciated by many
more users than the few, if any, vocal objectors.

>> @@ -1094,13 +1119,10 @@ foreach my $t (@files) {
>> =C2=A0 =C2=A0 =C2=A0 $message_id =3D undef;
>> =C2=A0}
>>
>> -if ($compose) {
>> - =C2=A0 =C2=A0 cleanup_compose_files();
>> -}
>> +cleanup_compose_files();
>>
>> =C2=A0sub cleanup_compose_files() {
>> - =C2=A0 =C2=A0 unlink($compose_filename, $compose_filename . ".fina=
l");
>> -
>> + =C2=A0 =C2=A0 unlink($compose_filename, $compose_filename . ".fina=
l") if $compose;
>> =C2=A0}
>
> Does this hunk have anything to do with this topic, or is it just a c=
hurn
> that does not change any behaviour?

The former. You'll notice there is a "quit" option in the prompt (in
addition to yes/no/all). The quit option needs to call
cleanup_compose_files(), so it now has two callers.

Instead of both callers having to do this:

  if ($compose) {
       cleanup_compose_files();
  }

I just moved the if compose test into the function so each caller can
simply ask:

  cleanup_compose_files();


>> @@ -175,15 +180,13 @@ test_set_editor "$(pwd)/fake-editor"
>>
>> =C2=A0test_expect_success '--compose works' '
>> =C2=A0 =C2=A0 =C2=A0 clean_fake_sendmail &&
>> - =C2=A0 =C2=A0 echo y | \
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 GIT_SEND_EMAIL_NOTTY=3D1=
 \
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 git send-email \
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 --compose --subject foo =
\
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 --from=3D"Example <nobod=
y@example.com>" \
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 --to=3Dnobody@example.co=
m \
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 --smtp-server=3D"$(pwd)/=
fake.sendmail" \
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 $patches \
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 2>errors
>> + =C2=A0 =C2=A0 git send-email \
>> + =C2=A0 =C2=A0 --compose --subject foo \
>> + =C2=A0 =C2=A0 --from=3D"Example <nobody@example.com>" \
>> + =C2=A0 =C2=A0 --to=3Dnobody@example.com \
>> + =C2=A0 =C2=A0 --smtp-server=3D"$(pwd)/fake.sendmail" \
>> + =C2=A0 =C2=A0 $patches \
>> + =C2=A0 =C2=A0 2>errors
>> =C2=A0'
>
> How would test this break without this hunk? =C2=A0"echo" dies of sig=
pipe, or
> something?
>
> I am not objecting to this particular change; just asking why this ch=
ange
> is here. =C2=A0"It does not break, but the command shouldn't ask for
> confirmation, and giving 'y' into it is unnecessary" is a perfectly
> acceptable answer, but if that is the case you probably would want to
> verify that the command indeed does go ahead without asking.

The hunk is there because the "echo y" is redundant with confirm=3Dneve=
r
which is now set early.

> These all test you would get a prompt when you as the author expect t=
he
> code to give one. =C2=A0Do you also need tests that verify you do not=
 ask
> needless confirmation when the code shouldn't?

Yes, I couldn't think how to test that last night for some reason, but
it is obvious to me now. I can send a followup.

>> =C2=A0test_expect_success '--compose adds MIME for utf8 body' '
>> =C2=A0 =C2=A0 =C2=A0 clean_fake_sendmail &&
>> =C2=A0 =C2=A0 =C2=A0 (echo "#!$SHELL_PATH" &&
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0echo "echo utf8 body: =C3=A0=C3=A9=C3=AC=C3=
=B6=C3=BA >>\"\$1\""
>> =C2=A0 =C2=A0 =C2=A0 ) >fake-editor-utf8 &&
>> =C2=A0 =C2=A0 =C2=A0 chmod +x fake-editor-utf8 &&
>> - =C2=A0 =C2=A0 echo y | \
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 GIT_EDITOR=3D"\"$(pwd)/fake-editor-utf8\=
"" \
>> - =C2=A0 =C2=A0 =C2=A0 GIT_SEND_EMAIL_NOTTY=3D1 \
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 git send-email \
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 --compose --subject foo \
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 --from=3D"Example <nobody@example.com>" =
\
>
> If the change you made to git-send-email.perl is later broken and the
> command (incorrectly) starts asking for confirmation with these comma=
nd
> line options, what does this test do? =C2=A0Does it get stuck, forbid=
ding the
> test suite to be run unattended?

Many of the tests (because they automatically cc) will hang waiting on
input if git-send-email.perl is later broken in such a way as to start
ignoring --compose.

I could not think of a good way to avoid this. We could possibly "echo
y|" redundantly to every test, but even that does not guarantee that
one of the other prompts cannot cause a hang. So this potential to
hang, I think, already exists.

The best I could think of was something like (sleep 60 && kill $$) &;
sleep_pid=3D$!; ... kill $sleep_pid; wrapping each test, or even the
entire script. Suggestions here appreciated.

But, I think this can largely be addressed by testing that the change
does *not* prompt when it shouldn't, and moving that test before any
of the existing tests which could prompt.

j.
