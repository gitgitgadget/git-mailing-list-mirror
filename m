From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] completion: improve untracked directory filtering for
 filename completion
Date: Thu, 19 Sep 2013 12:31:10 -0700
Message-ID: <20130919193109.GA9464@google.com>
References: <CADHXV5=ZVif6xppJgOXRKmqG9bBmAF0=A-sS9TUkH1RHSX9k6g@mail.gmail.com>
 <1379523968-20668-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Isaac Levy <ilevy@google.com>, git@vger.kernel.org,
	Manlio Perillo <manlio.perillo@gmail.com>
To: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Thu Sep 19 21:31:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VMjwn-0006mI-Ax
	for gcvg-git-2@plane.gmane.org; Thu, 19 Sep 2013 21:31:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752417Ab3ISTbS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 19 Sep 2013 15:31:18 -0400
Received: from mail-pb0-f42.google.com ([209.85.160.42]:59732 "EHLO
	mail-pb0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751822Ab3ISTbR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Sep 2013 15:31:17 -0400
Received: by mail-pb0-f42.google.com with SMTP id un15so8825080pbc.1
        for <git@vger.kernel.org>; Thu, 19 Sep 2013 12:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=jO/tBhfCU2Q2lDcOGVqRDvTfU2cYZ3JGkExUdfc9CGg=;
        b=A5Bp37ZfbhRhAqitQII0FFYhjpvWaU9BdRQCara8jHPXDWFZj9cBFgzIuT1wSrsz0T
         H5iE+TQs/pyn/wwEgv20VHYFb4A/UKjdeUSSUzH0AJv+iViuhvuA50tBsqRGYR5BQuZN
         vzQHjnG7WJJDxUedTv6TMEhrehEzpC4AFeDJu9ZMxyJ0MKanOe5Q+8LjzVNil2FfcFe6
         Os5dgOfYB5anaHG1V1XxDF4P/2TJ/9Jzc99DSI17znG8aHcKEmX5XhNxqF7oeheZS9Dw
         07Nc2rGyfJgO7Khz61dZN2QYUsMXJ93P5vW9gW1Uv+837A4lR+nWgv3OsRZ1MoV08Qx0
         CpcQ==
X-Received: by 10.66.102.100 with SMTP id fn4mr4559492pab.71.1379619077055;
        Thu, 19 Sep 2013 12:31:17 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id tz3sm10994699pbc.20.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 19 Sep 2013 12:31:16 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1379523968-20668-1-git-send-email-szeder@ira.uka.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235025>

SZEDER G=E1bor wrote:

>   $ time __git_index_files "--others --modified"
>   untracked-dir
>
>   real	0m0.537s
>   user	0m0.452s
>   sys	0m0.160s
>
> Eliminate this delay by additionally passing the '--directory
> --no-empty-directory' options to 'git ls-files' to show only the
> directory name of non-empty untracked directories instead their whole
> content:
>
>   $ time __git_index_files "--others --modified --directory --no-empt=
y-directory"
>   untracked-dir
>
>   real	0m0.029s
>   user	0m0.020s
>   sys	0m0.004s

Nice.  This is what "git status" uses, too.

> Filename completion for 'git clean' suffers from the same delay, as i=
t
> offers untracked files, too.  The fix could be the same, but since it
> actually makes sense to 'git clean' empty directories, in this case w=
e
> only pass the '--directory' option to 'git ls-files'.

Also sensible.

=46or what it's worth,
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
