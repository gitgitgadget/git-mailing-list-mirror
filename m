From: Eric Frederich <eric.frederich@gmail.com>
Subject: Re: cvs importing a forked project
Date: Tue, 5 Oct 2010 14:38:37 -0400
Message-ID: <AANLkTi=DRWeJc5gW0Rio9NZh5a02FQtdd9TeEzOkBimr@mail.gmail.com>
References: <AANLkTimvaH4UYzmL9eS1Yq7WNaS+jPRfkajKPP=hjZWV@mail.gmail.com>
	<Ci4laGuWQaUrmZdwH9nojZ77bfNScQVKlCGXCSR6hP816oyKCfkncQ@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Tue Oct 05 20:38:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P3CPZ-0006NU-MI
	for gcvg-git-2@lo.gmane.org; Tue, 05 Oct 2010 20:38:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751583Ab0JESin convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 5 Oct 2010 14:38:43 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:34641 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750930Ab0JESim convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 5 Oct 2010 14:38:42 -0400
Received: by wwj40 with SMTP id 40so6005845wwj.1
        for <git@vger.kernel.org>; Tue, 05 Oct 2010 11:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Lj0YfoS5CA96mEWZd6AY51iy0MWhsFS/cNLAxgsIAy8=;
        b=Pn5yztARKQgSpEVjAZB/9Bz2ZaTh/N61dhZueiYVOMzkj+LyWw4KXveCfzP5lId8pb
         TO2syTXg1nHbyebdpCvJCwAXsqEJIp4ETF+ZN2/WZFQmZcdTZbJNpBSqLlajpVosRM5A
         rJcPaGpbakVWsfVIOQgclIzA76Nn6xsoe3egA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=lmgcYNS6dA7gb78AWSr+AWPghSpo7UfZC5okGjWQI/gax4gYWvsLj9uKyw33Ddxh8L
         YjjEnkSLRPYlM3h0w3d+33kUm/2q+H0kagM19aoZJPSkhP6X/v0WqAEOo60VSXmoNlV+
         racIjmUeFv+Ha18xloiMKnMGp39tMzJJGFsnQ=
Received: by 10.216.179.20 with SMTP id g20mr9573717wem.45.1286303917564; Tue,
 05 Oct 2010 11:38:37 -0700 (PDT)
Received: by 10.216.80.144 with HTTP; Tue, 5 Oct 2010 11:38:37 -0700 (PDT)
In-Reply-To: <Ci4laGuWQaUrmZdwH9nojZ77bfNScQVKlCGXCSR6hP816oyKCfkncQ@cipher.nrlssc.navy.mil>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158221>

Interesting.  Looks easy to use except I can't figure out how to get
the two projects imported to the same git project.

If I run the following...

$ git cvsimport -C myproject -d /some/vault projects/foo_old
$ git cvsimport -C myproject -d /some/vault projects/foo_new

=2E.. then the projects look to be merged at some arbitrary point in
time based on date.
I'm not even sure if the entire history of foo_new is imported.
This is just based off of what gitk is showing me but it seems to take
the entire history of foo_old but when importing foo_new but it looks
like only commits made after the last commit of foo_old are imported.

Obviously this isn't even using grafts since there is no grafts file.
How do I get these two projects imported in their entirety into a
single git repository so that I can create my own grafts file?
Also, once I have my two projects imported into the same grafts file
they should be completely independent right?... how do I switch
between them then or even know what the SHA-1's are if they're not
connected at all?

Thanks,
~Eric

On Fri, Oct 1, 2010 at 1:57 PM, Brandon Casey
<brandon.casey.ctr@nrlssc.navy.mil> wrote:
> On 10/01/2010 12:38 PM, Eric Frederich wrote:
>> Hello,
>>
>> I have a project (several actually) where development was done in cv=
s
>> for 10 years. =A0Then, about 5 years ago, a copy of the latest was m=
ade
>> and development continued in a new project.
>> Development in the old project stopped for the most part.
>>
>> Is there any way where I can combine these two projects in git?
>> Basically, take the newer project's first commit and make its parent
>> the the last commit of the older project.
>> Development was pretty linear.
>
> You can do this very easily using grafts.
>
> =A0 https://git.wiki.kernel.org/index.php/GraftPoint
>
> filter-branch can be used to rewrite the history and make the grafts
> permanent.
>
> -Brandon
>
