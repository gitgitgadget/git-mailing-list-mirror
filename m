From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v3 3/7] completion: add new __gitcompadd helper
Date: Fri, 12 Apr 2013 13:47:15 -0500
Message-ID: <CAMP44s2rE2nniJhC_ZpsdNbp5uZ=tCo+wV6ygth2R5xiVTN=ng@mail.gmail.com>
References: <1365577077-12648-1-git-send-email-felipe.contreras@gmail.com>
	<1365577077-12648-4-git-send-email-felipe.contreras@gmail.com>
	<7vli8neiqi.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	=?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 12 20:47:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQj0M-0002wI-Ot
	for gcvg-git-2@plane.gmane.org; Fri, 12 Apr 2013 20:47:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754318Ab3DLSrR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Apr 2013 14:47:17 -0400
Received: from mail-lb0-f177.google.com ([209.85.217.177]:40693 "EHLO
	mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752539Ab3DLSrQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Apr 2013 14:47:16 -0400
Received: by mail-lb0-f177.google.com with SMTP id r10so2892164lbi.22
        for <git@vger.kernel.org>; Fri, 12 Apr 2013 11:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=J10K+oWHMJKUbqAYqFrPl3oPpy3cls0sMU5E9msZ9fI=;
        b=abFtNcHKVBC56ln+gTJDlYRgFpCDo7I5ORQUt4PkKHgPhSDVoFMt590Q4UOQqJksls
         EceD+mMILtgB4timjKuDHK/uHS86wIfzKru+f+IjONOirBz0wIAajWt0aKxzSwkxs78W
         lQopcZtEQWHy54gRQkaB4BbTw/9sM2tGLyC2TTZIXJjnpVvSwRycGdKi09ZcVFso14Zf
         mkWUvFBIYs2j3lp/ZAKRQOg+S/grrPKyKAi53DbUMhiouar+q3sijWjJAgBbwcXm0jKL
         K5pYsVELWf+2xi5UWFWyZUQq+VDXQ7vccBk4jMdrQBYa9sTFNi7inGsxVWHnCjItmUl9
         oDGw==
X-Received: by 10.112.146.133 with SMTP id tc5mr5881878lbb.88.1365792435464;
 Fri, 12 Apr 2013 11:47:15 -0700 (PDT)
Received: by 10.114.59.210 with HTTP; Fri, 12 Apr 2013 11:47:15 -0700 (PDT)
In-Reply-To: <7vli8neiqi.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221010>

On Fri, Apr 12, 2013 at 12:55 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:

>>  }
>>
>>  # Generates completion reply with compgen from newline-separated possible
>> @@ -1820,7 +1823,7 @@ _git_config ()
>>               local remote="${prev#remote.}"
>>               remote="${remote%.fetch}"
>>               if [ -z "$cur" ]; then
>> -                     COMPREPLY=("refs/heads/")
>> +                     __gitcompadd "refs/heads/"
>
> I am not sure about this one, though.
>
> Other callers took pains to protet against triggering unset variable
> references by using ${1-} instead of ${1}.  Shouldn't this caller be
> passing three empty strings?

Perhaps, or perhaps we were being too careful before: 'compgen -W foo'
is the same as 'compgen -W foo -S "" -P "" -- ""'.

--
Felipe Contreras
