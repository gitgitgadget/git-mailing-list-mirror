From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: Patch that modifies git usage message
Date: Fri, 1 May 2015 13:40:21 -0400
Message-ID: <CAPig+cROY5ZaXtAWpaMpe8JsuG1eSp2jhAsSh1dAsCSACgoFxw@mail.gmail.com>
References: <CAKB+oNtYbJXNb2wGzJCdQ5Ru5fq3HzcapSqiTVC_34=xDnTb7Q@mail.gmail.com>
	<CAGZ79kY1ZoYrVwVVqfyB+uMGsJo59qDxbDLgyo5qygSm=CUVhA@mail.gmail.com>
	<xmqqfv7gxnup.fsf@gitster.dls.corp.google.com>
	<CAKB+oNtKi6e7H9U75WEJDKH2KK349JT+vGE8+acHvM6SasCWfQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Stefan Beller <sbeller@google.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Alangi Derick <alangiderick@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 01 19:40:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YoEvR-0002iq-7e
	for gcvg-git-2@plane.gmane.org; Fri, 01 May 2015 19:40:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751490AbbEARk0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 May 2015 13:40:26 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:35036 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751388AbbEARkV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 May 2015 13:40:21 -0400
Received: by iejt8 with SMTP id t8so93811328iej.2
        for <git@vger.kernel.org>; Fri, 01 May 2015 10:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=ZrhZfpU2QD+YECMrwtzydEzUEv80eaM4jtojsLLMqKg=;
        b=Ygo1OV2uhS6vLOGmdmuIx7M0e+173LdE+Z2mRskPb7lNHOcj9cbns1W8oMPgLV1HrO
         2bjewF54AM0S4khHFtLqbNlEdkiMIO3X79sz0RvwyYAy/3Orwe8v49BgVKVo7V6DMF3r
         aezQr67RqSRgpelbxWviZV7pReFmLkBU/hZ/KswsLAc/uk784Nd0oCRvfw+7cwglTWp/
         r1zMjKNM1EIOx29QX7XjZTnQVNGiJoPVurZ1fj0AuGpvMYYInxvF8cHpsHPpjgduqyId
         jUSbRVBD2RUWpkyAvezi1AboJ8SDS7Y8eecpyhwcViRmZIqWldli8MhT4rRuuR+Wg3Q9
         NQrA==
X-Received: by 10.107.31.134 with SMTP id f128mr13710562iof.19.1430502021341;
 Fri, 01 May 2015 10:40:21 -0700 (PDT)
Received: by 10.107.28.132 with HTTP; Fri, 1 May 2015 10:40:21 -0700 (PDT)
In-Reply-To: <CAKB+oNtKi6e7H9U75WEJDKH2KK349JT+vGE8+acHvM6SasCWfQ@mail.gmail.com>
X-Google-Sender-Auth: O3-ahCnEOro2CApy6KuPauCEifg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268164>

(Etiquette on this list is to reply inline rather than top-posting[1].)

On Fri, May 1, 2015 at 12:38 PM, Alangi Derick <alangiderick@gmail.com> wrote:
> What about the other strings used for
> error display? For example
> die("cannot handle %s as a builtin", cmd);
> Can't i change the "cannot" to "Cannot"? Or is there a problem with
> that one too?

Despite inconsistencies in existing code, lowercase in new error
messages is intentional. Documentation/CodingGuidelines has this to
say[2]:

    Error Messages

    - Do not capitalize ("unable to open %s", not "Unable to
      open %s")

Therefore, a goal more aligned with this recommendation would be to
submit a patch which changes capitalized error messages to lowercase,
however, heed this warning[3] from CodingGuidelines:

   - Fixing style violations while working on a real change as a
     preparatory clean-up step is good, but otherwise avoid useless
     code churn for the sake of conforming to the style.

     "Once it _is_ in the tree, it's not really worth the patch noise
     to go and fix it up."
     Cf. http://article.gmane.org/gmane.linux.kernel/943020

Sometimes there are exceptions. One may be able to argue that making
user-facing messages more consistent is worthwhile (for instance [4]).

Finally, changing "usage:" to "Usage:" would undo recent work to
improve consistency of usage messages[4].

[1]: https://lkml.org/lkml/2005/1/11/111
[2]: https://github.com/git/git/blob/master/Documentation/CodingGuidelines#L416
[3]: https://github.com/git/git/blob/master/Documentation/CodingGuidelines#L21
[4]: http://thread.gmane.org/gmane.comp.version-control.git/216961
