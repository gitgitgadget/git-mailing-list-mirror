From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH 6/9] ref-filter: introduce format_ref_array_item()
Date: Wed, 7 Oct 2015 01:20:35 +0530
Message-ID: <CAOLa=ZRxjcmKQ+Jucwk8zSoeZzJyXQQCc=R89Cg8ci5nXzQwJw@mail.gmail.com>
References: <1443807546-5985-1-git-send-email-Karthik.188@gmail.com>
 <1443807546-5985-7-git-send-email-Karthik.188@gmail.com> <vpqoagg9n2l.fsf@grenoble-inp.fr>
 <CAOLa=ZTMf9i=+9Rgi9oO==vr_JGtG3J9DvQWk18Zx-yd5_35XA@mail.gmail.com>
 <vpq1td9zolv.fsf@grenoble-inp.fr> <CAOLa=ZSr19+0OVoyACdN_YfSFeWugtS40WNu0GB9=uZFEu8N5A@mail.gmail.com>
 <vpqlhbfg52l.fsf@grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Oct 06 21:51:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZjYGY-00010b-35
	for gcvg-git-2@plane.gmane.org; Tue, 06 Oct 2015 21:51:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752577AbbJFTvH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Oct 2015 15:51:07 -0400
Received: from mail-vk0-f53.google.com ([209.85.213.53]:35624 "EHLO
	mail-vk0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752313AbbJFTvG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Oct 2015 15:51:06 -0400
Received: by vkao3 with SMTP id o3so124217171vka.2
        for <git@vger.kernel.org>; Tue, 06 Oct 2015 12:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=/z8blBluiQ093kZaVRF7y72umVBVZ0WqPV+N6NYoHIE=;
        b=sBtdkx2ZoHG+d00wimRpqisONS249+LtnTRfZxnCq1TCIWF+T7PN8R+79s0MkJ4E05
         eKefFp9InFt+ft0zZWTOVNsljDJEjmnsTjoU38WKVquu1LsEwZcFEAUnwiuOLBcOPMie
         eu7p1l0jgUedZ2jijhYrm7anBsJjpiB03us+cXbutpt42h56UZizbEz6OAWogJNcc0hs
         pTjEhlA/T37NGS8qonTFC5Q1ZuAhWy2J++lzmImpdUIDA/qWnTnqxOB514794fnDbDSQ
         aQxH1udMOgLGrWBsXhdBar33hfFPGFxeVDdbJh5XI1trcDRdcDlCB/dF/u6prYL4ov4F
         ejMw==
X-Received: by 10.31.162.81 with SMTP id l78mr24997874vke.13.1444161064499;
 Tue, 06 Oct 2015 12:51:04 -0700 (PDT)
Received: by 10.103.23.193 with HTTP; Tue, 6 Oct 2015 12:50:35 -0700 (PDT)
In-Reply-To: <vpqlhbfg52l.fsf@grenoble-inp.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279164>

On Wed, Oct 7, 2015 at 1:08 AM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> On Mon, Oct 5, 2015 at 2:19 PM, Matthieu Moy
>> <Matthieu.Moy@grenoble-inp.fr> wrote:
>>> Karthik Nayak <karthik.188@gmail.com> writes:
>>>> which does not play well with the implementation of --column as done
>>>> in tag.c. Where, If I'm not wrong the --column option captures all
>>>> output, formats it and then prints it to stdout. Hence when using
>>>> colors, we're told that the printing isn't done to a tty which
>>>> supports colors, hence we lose out on colors.
>>>
>>> What I don't understand is how --column is different from --no-column
>>> wrt colors.
>>>
>>> In any case, this should be explained better in comments.
>>
>> Well, If we use column the way we do in tag.c then it'll replace the tty
>> and color will not print color because it will assume the output tty doesn't
>> support colors.
>>
>> I hope that's what you're asking
>
> Looking a bit more closely at the code, I think I understand what's
> going on. branch.c used print_columns which does all the clever things
> wrt columns display. tag.c used run_column_filter which pipes the output
> to "git column" (hence, indeed, color detection does not work since
> we're writting to a pipe).
>
> The branch.c way seems good to me (why fork another process when we can
> format the list ourselves ?). Probably tag.c could (should?) be modified
> to use it too. It should just be justified, like, replacing this commit
> message with:
>

Yes! this :)


> -- 8< --
> To allow column display, we will need to first render the output in a
> string list to allow print_columns() to compute the proper size of each
> column before starting the actual output. Introduce the function
> format_ref_array_item() that does the formatting of a ref_array_item to
> an strbuf.
>
> show_ref_array_item() is kept as a convenience wrapper around it which
> obtains the strbuf and prints it the standard output.
> -- 8< --
>

Looks Good.

> and adding a comment next to if (column_active(colopts)) { in patch
> 8/9:
>
>         /* format to a string_list to let print_columns() do its job */
>

Will do this, thanks a bunch

-- 
Regards,
Karthik Nayak
