From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 2/2][GSoC 2014] diff: used is_dot_or_dotdot() in code
Date: Wed, 19 Mar 2014 00:08:33 -0400
Message-ID: <CAPig+cQJm7MoftaGd5=p-ooLVQQguzhwsYHNFgjjzywyq-UC=A@mail.gmail.com>
References: <CAM+=D-Ac2yL02-6qGQFuV_qz4FKt_6EGwRHk4+MLDnSb5CgucQ@mail.gmail.com>
	<1395192636735-7605956.post@n2.nabble.com>
	<CAPig+cSxu1WAEg7YmnNn-kHZMj4AacRaVPMthgAwFN0GmrrYCg@mail.gmail.com>
	<CAM+=D-CO9A4hYb+9tVf_cAOMqkTm3taBLPp0eHtFkuMUCFw2ng@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>
To: Brian Bourn <ba.bourn@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 19 05:08:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQ7ny-00019n-D8
	for gcvg-git-2@plane.gmane.org; Wed, 19 Mar 2014 05:08:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751869AbaCSEIe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Mar 2014 00:08:34 -0400
Received: from mail-yh0-f53.google.com ([209.85.213.53]:48235 "EHLO
	mail-yh0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751553AbaCSEId (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Mar 2014 00:08:33 -0400
Received: by mail-yh0-f53.google.com with SMTP id v1so7907060yhn.26
        for <git@vger.kernel.org>; Tue, 18 Mar 2014 21:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=0FV4XJRbDp6rm1UxnUT4tlI2gplrwW0iyab6l9wT84U=;
        b=M/rv3Eb9bN4/qzqH1kmdVAsaoCX08A54i5h3hzVC8t5h62yeOimi/n73aKB3Rhf0vp
         NVAMZitEFIxf4PjFO2sxwfHbcQ40YZUSDfoAYqddNGMetp2orou8fJ/QO8wXg78QT9wB
         LR+kby+vpqUtogBIu5RiLebf9pGrAfMNnoNaVY5l4QAlQLTlT86/Ly7yaWpeG3qfBc33
         no+P1sYcGlMliVoKmPWvPECiMyap14QR6Y35XWVwrMfHuwe7hcsQ8KE7NdfVpeCOUZUU
         hJYVgfl//I5DZBXj/BXnL0XojMUb20fXrQWk67d0Me73qPXMza0yA0rJfwSrw51X+NLW
         hF5w==
X-Received: by 10.236.81.237 with SMTP id m73mr47668020yhe.29.1395202113166;
 Tue, 18 Mar 2014 21:08:33 -0700 (PDT)
Received: by 10.170.180.134 with HTTP; Tue, 18 Mar 2014 21:08:33 -0700 (PDT)
In-Reply-To: <CAM+=D-CO9A4hYb+9tVf_cAOMqkTm3taBLPp0eHtFkuMUCFw2ng@mail.gmail.com>
X-Google-Sender-Auth: o6xijaXFXlfoeNCg6OQdA4K-HyM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244409>

On Tue, Mar 18, 2014 at 11:58 PM, Brian Bourn <ba.bourn@gmail.com> wrote:
> On Tue, Mar 18, 2014 at 11:45 PM, Eric Sunshine <sunshine@sunshineco.com>
> wrote:
>> On Tue, Mar 18, 2014 at 9:30 PM, babourn <ba.bourn@gmail.com> wrote:
>> > Subject: diff: used is_dot_or_dotdot() in code
>> > Signed-off-by: Brian Bourn <bab2177@columbia.edu>
>> > ---
>> >  diff-no-index.c | 2 +-
>> >  1 file changed, 1 insertion(+), 1 deletion(-)
>> >
>> > diff --git a/diff-no-index.c b/diff-no-index.c
>> > index ba915af..44cce25 100644
>> > --- a/diff-no-index.c
>> > +++ b/diff-no-index.c
>> > @@ -26,7 +26,7 @@ static int read_directory_contents(const char *path,
>> > struct string_list *list)
>> >   return error("Could not open directory %s", path);
>> >
>> >   while ((e = readdir(dir)))
>> > - if (strcmp(".", e->d_name) && strcmp("..", e->d_name))
>> > + if (!is_dot_or_dotdot(e->d_name))
>>
>> The patch is severely whitespace-damaged. (Did you post it through
>> Nabble?)
>
>    I did post through Nabble, My email with the patch didn't seem to be
> going through.
>    should I keep trying to resend it through email to undo the whitspace
> damage?

It's probably not necessary to try resending this version of the patch
since you'll (hopefully) be sending a newer version which takes
reviewer comments into consideration.

What method are you using to send the patches? git send-email?
Something other? This particular mailing list rejects HTML-formatted
messages, so that could be the culprit if you pasted the patch into
your email client. It's a good idea to try sending patches to yourself
via "git send-email". If you can get that to work successfully, then
they should be accepted by the mailing list when sent via the same
mechanism.
