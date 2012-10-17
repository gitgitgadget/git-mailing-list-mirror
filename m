From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v5 2/3] tests: use __gitcompadd to simplify completion tests
Date: Wed, 17 Oct 2012 20:26:49 +0200
Message-ID: <CAMP44s1L_0FS4jrdb4aFxgPENrO1ySMXhCqJt3QiODhbuTPFQA@mail.gmail.com>
References: <1350229971-9343-1-git-send-email-felipe.contreras@gmail.com>
	<1350229971-9343-3-git-send-email-felipe.contreras@gmail.com>
	<20121017175040.GE2156@goldbirke>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>
To: =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Wed Oct 17 20:27:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TOYKb-0003sP-JL
	for gcvg-git-2@plane.gmane.org; Wed, 17 Oct 2012 20:27:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757611Ab2JQS0u convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 17 Oct 2012 14:26:50 -0400
Received: from mail-oa0-f46.google.com ([209.85.219.46]:54212 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752466Ab2JQS0t convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 17 Oct 2012 14:26:49 -0400
Received: by mail-oa0-f46.google.com with SMTP id h16so7752942oag.19
        for <git@vger.kernel.org>; Wed, 17 Oct 2012 11:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=GNAKUuQy+wLwpF0b8SN5PiBPmFDjIYpzjwqEmQ+EvKM=;
        b=gilPfVJlHyHc0WvFUn5bZItHvZg7MTY5vWgqAMI4uu4WcWjbFCNips5HTq0k4RTstv
         ruZSGUt+fsA3w+LzBm24uXJ+68UTxl9tul+a0tuys4Ef+ydcmPZKWXKViiNHjklhz4p7
         F8ozxRqEShZpEXywzHP8Xln5cJkgReziODqzVh1UbZQmRBzVgkLFMXfZBht2r+2kdHRt
         LhkUctULfck3o5L/7otqkOEpgM4o/2tny8YB4VbxON1em2xfqJS7HvHCP6ZcNI7D9U13
         IgHh9kiBa/b7y36ZLGa7t8YLJQ1VdMJQy45UpE3nG9f9bU/HErBlC9k3Q0n4k2qi51Ed
         L42A==
Received: by 10.182.116.6 with SMTP id js6mr15838764obb.82.1350498409235; Wed,
 17 Oct 2012 11:26:49 -0700 (PDT)
Received: by 10.60.58.137 with HTTP; Wed, 17 Oct 2012 11:26:49 -0700 (PDT)
In-Reply-To: <20121017175040.GE2156@goldbirke>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207931>

On Wed, Oct 17, 2012 at 7:50 PM, SZEDER G=C3=A1bor <szeder@ira.uka.de> =
wrote:
> On Sun, Oct 14, 2012 at 05:52:50PM +0200, Felipe Contreras wrote:
>> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
>> ---
>>  t/t9902-completion.sh | 29 +++++++++--------------------
>>  1 file changed, 9 insertions(+), 20 deletions(-)
>>
>> diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
>> index 92d7eb4..49c6eb4 100755
>> --- a/t/t9902-completion.sh
>> +++ b/t/t9902-completion.sh
>> @@ -39,19 +39,18 @@ _get_comp_words_by_ref ()
>>       done
>>  }
>>
>> -print_comp ()
>> +__gitcompadd ()
>>  {
>> -     local IFS=3D$'\n'
>> -     echo "${COMPREPLY[*]}" > out
>> +     compgen -P "${2-}" -S "${4- }" -W "$1" -- "${3-$cur}" > out
>>  }
>
> Please don't.  Running compgen is a fundamental part of the completio=
n
> script, therefore tests must run it as it is in the completion script
> and not some copy of it.

All right. I added this patch as an after though to help sell the idea
of __gitcompadd. Either  way I'm not to worried about overriding it,
we are not really exercising any code that could catch issues with
calling compgen; we probably need specialized tests for that. In fact
I amended the quote you are quoting above as it's totally different
from the proposed __gitcompadd, but it still works nonetheless.

--=20
=46elipe Contreras
