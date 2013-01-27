From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH 1/4] mergetool--lib: Simplify command expressions
Date: Sun, 27 Jan 2013 14:18:15 -0800
Message-ID: <CAJDDKr61wS1ruPYDW4+exWBWveyS0Dp7Gmu5gWRh_99-frc_7Q@mail.gmail.com>
References: <1359321886-80523-1-git-send-email-davvid@gmail.com>
	<1359321886-80523-2-git-send-email-davvid@gmail.com>
	<5105A56E.4010002@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	John Keeping <john@keeping.me.uk>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Sun Jan 27 23:18:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TzaYh-0005mD-K2
	for gcvg-git-2@plane.gmane.org; Sun, 27 Jan 2013 23:18:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756677Ab3A0WSS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Jan 2013 17:18:18 -0500
Received: from mail-wi0-f169.google.com ([209.85.212.169]:45510 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756615Ab3A0WSR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Jan 2013 17:18:17 -0500
Received: by mail-wi0-f169.google.com with SMTP id hq12so998100wib.2
        for <git@vger.kernel.org>; Sun, 27 Jan 2013 14:18:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=aKllxextEwGBqPmq6+QRIVSFXx7SJ5GVKlP1xkGN2nM=;
        b=nQLLK6SdvJ/vjRsTr7UnHYHB/WrTJ+VeWbZ96VyUFlcH21sCkQyDXTktGxGnEhNLJO
         SXPBijipLKuLwXKff8gkFe/3BW93iLfq4lCPzaCX5S8mM0SJR0z7gDa6Z3cRmAj9NKaT
         VGLmVaL3ok0s+NT4Vjn9XQqmt8B82pR0030CuVpOaCu0UkIDOjUBJNOEB2T47saJaR0E
         acSemef6sp9RQDPDhgUkmbp3adjLBZBHU3emedGlpfp3XfhuzaRpqBelHg0a4kEeX4Ys
         EJbf1qxC80+g6332RcDaxp0X6olbPtXkdsYQKyUbrupgDmzhCplcCYoaPlF+KFbmZ4BW
         7Q0w==
X-Received: by 10.180.73.212 with SMTP id n20mr4354199wiv.11.1359325095650;
 Sun, 27 Jan 2013 14:18:15 -0800 (PST)
Received: by 10.194.24.231 with HTTP; Sun, 27 Jan 2013 14:18:15 -0800 (PST)
In-Reply-To: <5105A56E.4010002@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214739>

On Sun, Jan 27, 2013 at 2:08 PM, Johannes Sixt <j6t@kdbg.org> wrote:
> Am 27.01.2013 22:24, schrieb David Aguilar:
>> Use $(command "$arg") instead of "$(command "$arg")" as the latter is
>> harder to read.
>
> If at all, you should restrict yourself to simplify only variable
> assignments. Because this case:
>
>> -     if test -z "$(get_merge_tool_cmd "$merge_tool")" &&
>> +     if test -z $(get_merge_tool_cmd "$merge_tool") &&
>
> cannot work as intended: If the output of $() is empty, then without the
> outer quotes this becomes
>
>   test -z
>
> without an operand for -z, which is a syntax error (of the test command).

Definitely.  I learned this the hard way when the tests broke on me while
working it ;-)  My patch rewrites things to always use var=$(command)
expressions with separate test "$var" evaluating them.
Thanks for the tip,
-- 
David
