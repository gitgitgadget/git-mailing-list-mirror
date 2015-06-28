From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [RFC/PATCH 1/9] ref-filter: add %(refname:lalignX) option
Date: Sun, 28 Jun 2015 14:43:14 +0530
Message-ID: <CAOLa=ZTkq9NWSu-Bd1iwxYD1yj9+URuQSopc_qjgxSbBv2t2uA@mail.gmail.com>
References: <CAOLa=ZSsVqFy4OrSt295qAZdjKTC7z44EVsx3cPEd2jb8Y-sHw@mail.gmail.com>
 <1435232596-27466-1-git-send-email-karthik.188@gmail.com> <xmqqsi9ce0xj.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jun 28 11:14:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z98fC-0001g0-By
	for gcvg-git-2@plane.gmane.org; Sun, 28 Jun 2015 11:14:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752108AbbF1JOA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Jun 2015 05:14:00 -0400
Received: from mail-oi0-f54.google.com ([209.85.218.54]:36325 "EHLO
	mail-oi0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751489AbbF1JN5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Jun 2015 05:13:57 -0400
Received: by oigb199 with SMTP id b199so100830033oig.3
        for <git@vger.kernel.org>; Sun, 28 Jun 2015 02:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=BWQc0bGn3mS6ONzdSDWBCmDnXVBA1aCPfJd+l4B15AQ=;
        b=M9NhlVzfcAw3lvVMrgVrUN4zSDeJ21laJSDI7wIM42MAbW1fUaB8RON2nKGeG+EeLJ
         530teJKwgcz8Kd6fqBh5MVpKowuy5Y4TdVoO0ggemd4SZFlJDmx9C7Raa5UdaEbMO9l4
         zEopQG/MWL3n3kLdhRXnCuz4imL1iz9uL0wW+VXYwUI5IDdOPiy0hJruI2A1xPuyIquh
         v1Ifa8FuQ/kKP+FiSSN1D0d9RqRxrLEXGNkUwOvCYV/8wZ30mOgSFixGqqtwhIFhasx7
         rdpNvEni1xiLRSmO9Ui3dr7MKpxSaj13Ow9GikT/vOaPosgYsnLr3WcXdEqLcJXTtpsU
         xEzA==
X-Received: by 10.202.73.198 with SMTP id w189mr8542112oia.102.1435482824322;
 Sun, 28 Jun 2015 02:13:44 -0700 (PDT)
Received: by 10.182.95.165 with HTTP; Sun, 28 Jun 2015 02:13:14 -0700 (PDT)
In-Reply-To: <xmqqsi9ce0xj.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272874>

On Sun, Jun 28, 2015 at 1:09 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> Add support for %(refname:lalignX) where X is a number.
>> This will print a shortened refname aligned to the left
>> followed by spaces for a total length of X characters.
>> If X is less than the shortened refname size, the entire
>> shortened refname is printed.
>
> Why would we even want this kind of thing in the first place?  Is
> this to make it possible to re-implement some option that exists
> already in 'git branch' or 'git tag' as a thin wrapper on top of
> this underlying feature?
> As a low-level plumbing, I'd rather not to see such an elaborate
> formatting option added to for-each-ref; after all, the design of
> the command to allow its output properly script-quoted is so that we
> can offload such non-essential (meaning: does not need anything only
> Git knows; computing the display width of a string and filling the
> output space is an example.  As opposed to something like --merged
> that needs help from Git, which has the ultimate knowledge on the
> topology) processing to Porcelain that uses the command as plumbing.
>

Well this is to support the printing of tag in `git tag -l`, if you
see the current
implementation we print refs using "printf("%-15s ", refname);" whenever the
"-n[<n>]" option is given, hence this patch to support printing of refs using a
required spacing.

I couldn't find a way to do with the current options available in
for-each-ref/ref-filter.
Is there a better way to go about this?

-- 
Regards,
Karthik Nayak
