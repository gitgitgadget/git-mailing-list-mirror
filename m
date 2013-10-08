From: Ted Zlatanov <tzz@lifelogs.com>
Subject: Re: [PATCH] git-credential-netrc: fix uninitialized warning
Date: Tue, 08 Oct 2013 16:04:06 -0400
Organization: =?utf-8?B?0KLQtdC+0LTQvtGAINCX0LvQsNGC0LDQvdC+0LI=?= @
 Cienfuegos
Message-ID: <87a9ijv8ax.fsf@flea.lifelogs.com>
References: <87zjqjx25g.fsf@flea.lifelogs.com>
	<20131008194147.GF9464@google.com> <87li23v8p5.fsf@flea.lifelogs.com>
	<525463F1.2050308@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Stefan Beller <stefanbeller@googlemail.com>
X-From: git-owner@vger.kernel.org Tue Oct 08 22:04:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VTdVj-0003yO-7i
	for gcvg-git-2@plane.gmane.org; Tue, 08 Oct 2013 22:04:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753668Ab3JHUD7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Oct 2013 16:03:59 -0400
Received: from mail-qa0-f49.google.com ([209.85.216.49]:35579 "EHLO
	mail-qa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752705Ab3JHUD6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Oct 2013 16:03:58 -0400
Received: by mail-qa0-f49.google.com with SMTP id i13so782335qae.8
        for <git@vger.kernel.org>; Tue, 08 Oct 2013 13:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lifelogs.com; s=google;
        h=from:to:cc:subject:organization:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-type;
        bh=K+uHQDbfMGNqAQcisOei6oR+EYnQQfXePGF3vUTlMv0=;
        b=vhwF12AlfDEEdNhepoTncZpbaVQNyb52LTuY8wJ6iXhkNpUwo3+suexc1opBaDH9r5
         H/V1eOznEFWBHponf8vhnTLnVjnRvO5tjoR7LO0lFRFBTTIsyLPBDveGJMG6HustvVTj
         6kKt5DZ86GiE+74NHKQOuVDhuDA3cjRhIxsLg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:organization:references:date
         :in-reply-to:message-id:user-agent:mime-version:content-type;
        bh=K+uHQDbfMGNqAQcisOei6oR+EYnQQfXePGF3vUTlMv0=;
        b=GassSFY2d2N0w5Pz3YA1Fk2pPVt80oWdH7H74CEtoL6TJhhYVtZRillXE4cU4QhLBU
         /XT9kAEtyUh1DcUxFIzUlFIXkBVnB1/nUZ3DVe2fqPQB5iOBjiD1JgSBx0JeOXqLG75G
         1PHk83ltXkNcLcvwi2j831f5E3vgcUPMnEVEYWvY5SlAvKWDqyQhL2j8d91R7/uxvTIq
         H8bqfVaqSLNAUBTybhI/fb5lLzJNcFIf41nyDXExZKT4hmjbtM7EJCVlRC9rYISkQjWE
         PBQkNombGM0TmeJ+3/U9vyuK1i3vVcfQgxW/rEihdMwkTeXXS8rIqareypjyBU8tN9/Y
         7u8A==
X-Gm-Message-State: ALoCoQmvUKBuTP6/UdxYx9jn7IO5/dcNxMO1bQSzzuOH1saqUR1umUxsAfY55pgHdMF+LjI5jz4m
X-Received: by 10.224.151.140 with SMTP id c12mr6347966qaw.94.1381262636669;
        Tue, 08 Oct 2013 13:03:56 -0700 (PDT)
Received: from flea.lifelogs.com (c-98-229-61-72.hsd1.ma.comcast.net. [98.229.61.72])
        by mx.google.com with ESMTPSA id ge5sm53546082qeb.5.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 08 Oct 2013 13:03:55 -0700 (PDT)
X-Face: bd.DQ~'29fIs`T_%O%C\g%6jW)yi[zuz6;d4V0`@y-~$#3P_Ng{@m+e4o<4P'#(_GJQ%TT= D}[Ep*b!\e,fBZ'j_+#"Ps?s2!4H2-Y"sx"
In-Reply-To: <525463F1.2050308@googlemail.com> (Stefan Beller's message of
	"Tue, 08 Oct 2013 21:58:41 +0200")
User-Agent: Gnus/5.130008 (Ma Gnus v0.8) Emacs/24.3.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235790>

On Tue, 08 Oct 2013 21:58:41 +0200 Stefan Beller <stefanbeller@googlemail.com> wrote: 

SB> On 10/08/2013 09:55 PM, Ted Zlatanov wrote:
JN> Sign-off?
>> 
>> I didn't realize it was a requirement, must I?

SB> Yes, this is a requirement. See Documentation/SubmittingPatches
SB> to read what signing off actually means here.

OK, I didn't realize it was.  Thanks for explaining.

Ted
