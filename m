From: Antoine Pelisse <apelisse@gmail.com>
Subject: Re: Premerging topics
Date: Tue, 23 Apr 2013 17:17:54 +0200
Message-ID: <CALWbr2xAxkNMedbuS-+pPy+Zc5MEhoCWk3oW8BXS9db63DoGAg@mail.gmail.com>
References: <CALWbr2wocjqs1mpa+yuQ_Zw8m+SX24q6Pby3E3v3-jd-0w1pvQ@mail.gmail.com>
	<CALKQrgfO9fd+EEA=Vwe94tJbxkX89uDmMHm9rj6L=d4x7JJjaQ@mail.gmail.com>
	<7vwqrtl2mk.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Johan Herland <johan@herland.net>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jeff King <peff@peff.net>, git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 23 17:18:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UUeyo-0003IQ-8I
	for gcvg-git-2@plane.gmane.org; Tue, 23 Apr 2013 17:18:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756698Ab3DWPR5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Apr 2013 11:17:57 -0400
Received: from mail-qe0-f48.google.com ([209.85.128.48]:57327 "EHLO
	mail-qe0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756695Ab3DWPRz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Apr 2013 11:17:55 -0400
Received: by mail-qe0-f48.google.com with SMTP id 9so456481qea.35
        for <git@vger.kernel.org>; Tue, 23 Apr 2013 08:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=vsR/wSq1zZFQrIt7tm3MSfk+C/DmB4BqeNxaTTLqBgs=;
        b=cZjqWYpiIbFxiRdHsJM5A9ZhOrwBpXyVbO3h/3zDmU+ddO2rKblHHg+lZ68KN+o+JO
         NeWP0TPJehjrs6M23t1AVMfnHxxcUzeIVmZ6gki5WTzRPYfITzsl2jBr/iCeATFBwJ88
         4VHyEa8cYpQttUiTPSAasDduQGSVPVaUnvOEuA1Q8016qIUeqBCPy99T4GrYoBUyMi5T
         c7fCxGgcWtE58UQrXXMnw2pkXZnYPijZuRJZA505iAAR3hk/alv02VYrATU8TjKfddJc
         SuDJec9+frZ6W+lE4jMiSGJ7D/Khn/GBTI050m94DKxGowAVFAXMzMt/qYpQeuyof0fJ
         C1oQ==
X-Received: by 10.224.179.6 with SMTP id bo6mr14051446qab.24.1366730274602;
 Tue, 23 Apr 2013 08:17:54 -0700 (PDT)
Received: by 10.49.30.9 with HTTP; Tue, 23 Apr 2013 08:17:54 -0700 (PDT)
In-Reply-To: <7vwqrtl2mk.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222177>

On Tue, Apr 23, 2013 at 4:53 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Johan Herland <johan@herland.net> writes:
>
>> Can you solve this problem with a tree object, instead of inventing a
>> specially-formatted blob?
>
> Hmm.  What problem are you guys trying to solve?
>
> [snipped..]
> And that was why I wanted to have a data structure that is quick to
> query to answer "I am about to merge B.  Does the history already
> have an A for which I have recorded a merge-fix for <A,B> pair?"

That's exactly the problem I'm trying to solve.
I'm willing to have an efficient way to merge topicC that has semantic
conflicts with topicA and topicB.
As topics will be merged together first in pu, then in next and
finally in master, chances are that they won't be merged in the same
order (or then, why would we even care about a topic workflow?). And I
have the feeling that "merge-fix/B" or "merge-fix/A" doesn't hold
enough information to do that accurately.

The idea is then to store the <A, B> pair as a note, and to associate
a "merge" to that (solving the semantic conflict). It would then be
used as an implicit third parent for the merge of "branch containing
A" and "branch containing B". This is pretty much what Michael said in
the $gmane you talked about.

Cheers,
Antoine
