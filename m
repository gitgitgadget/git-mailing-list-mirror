From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4 02/10] ref-filter: make the 'color' use ref_formatting_state
Date: Sun, 26 Jul 2015 00:28:39 -0400
Message-ID: <CAPig+cQ3tFFC8MMNfwo0V_hyYi8EoSfaQLei0+S+Tpz=2sMJ8g@mail.gmail.com>
References: <1437764685-8633-1-git-send-email-Karthik.188@gmail.com>
	<1437764685-8633-3-git-send-email-Karthik.188@gmail.com>
	<xmqq1tfxkz44.fsf@gitster.dls.corp.google.com>
	<CAOLa=ZT0LALR0gQaRfVnpyhScSKrSLP+QPQioe+uEH+KJYs=Ow@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 26 06:34:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZJDeA-0003wH-BP
	for gcvg-git-2@plane.gmane.org; Sun, 26 Jul 2015 06:34:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751068AbbGZE2l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Jul 2015 00:28:41 -0400
Received: from mail-yk0-f169.google.com ([209.85.160.169]:33236 "EHLO
	mail-yk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750960AbbGZE2k (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Jul 2015 00:28:40 -0400
Received: by ykfw194 with SMTP id w194so47236531ykf.0
        for <git@vger.kernel.org>; Sat, 25 Jul 2015 21:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=zJriy+Z2y561xVNYJusmzjb2RYAq8rSvhJxAi+Gp5go=;
        b=ZDiApn+mfTfZ8fNat0UeqBAWnrz81TB9QWo5yCW5Jc3ItK6zv13DezuLXAuBgrm4FB
         X7fJVq84VbUyiZsmF+kPG9rmF8DtItftH7cUF4c0bpUkXB9vXNOlxgH7c6NMRXeOWCGe
         vQsObachPK5wlUh1CWVuh2rYzuBe+PDCK/Xgj3MRzTiSkt9nGYfkTWujo3XdJMrDGmpO
         KIbLsGOPQ5vGVnA5RRnsRj1CX1pa8WhGob2dDrTKKLXccEqjcsXGyp+Ed0gS1bVhCiN6
         ujvnF3GdXAx1YX57vXMw/AgbmHTIWDBIRr4rqN2ab2FMPqQGvtZj8wU+HtG/+6wJwtfZ
         NdVw==
X-Received: by 10.170.220.214 with SMTP id m205mr23284853ykf.13.1437884919584;
 Sat, 25 Jul 2015 21:28:39 -0700 (PDT)
Received: by 10.37.12.129 with HTTP; Sat, 25 Jul 2015 21:28:39 -0700 (PDT)
In-Reply-To: <CAOLa=ZT0LALR0gQaRfVnpyhScSKrSLP+QPQioe+uEH+KJYs=Ow@mail.gmail.com>
X-Google-Sender-Auth: CwBQWIx8qpnkGOfJJQ5eLkPAHXw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274627>

On Sat, Jul 25, 2015 at 12:15 AM, Karthik Nayak <karthik.188@gmail.com> wrote:
> On Sat, Jul 25, 2015 at 3:16 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> Karthik Nayak <karthik.188@gmail.com> writes:
>>> Make color which was considered as an atom, to use
>>> ref_formatting_state and act as a pseudo atom. This allows
>>> interchangeability between 'align' and 'color'.
>>>
>>> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
>>> ---
>> I think 1/10 and 2/10 are the other way around.  Preferably, these
>> would be three patches, in this order:
>>
>>  (1) prepare the "formatting state" and pass it around; no other
>>      code change.
>>
>>  (2) have "color" use that facility.
>>
>>  (3) add a new feature using that facility.
>>
>> The first two may want to be combined into a single patch, if it
>> does not make the patch too noisy.
>
> Ill reverse the patches and merge the first two as you suggested.

While reviewing patch 1/10, it required more effort and was
distracting to have to separate out (mentally) changes which were
specific to the new %(align:X) pseudo-atom and those which introduced
the "formatting state". As such, it probably would be a good idea to
aim for the three distinct patches suggested by Junio rather than
aiming, up front, to merge the first two. After all, they are
conceptually distinct changes, and keeping them separate is friendlier
to reviewers. In the end, you may find that patch 1 is so trivial that
it can be merged with patch 2 without making review more difficult,
however, keeping them distinct during development helps you avoid
conflating unrelated changes.
