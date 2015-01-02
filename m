From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: xfuncname problems with C++
Date: Fri, 2 Jan 2015 14:05:56 -0800
Message-ID: <20150102220556.GH29365@google.com>
References: <CAHd499Cn8C51i_+Dm4h_U4X_Jc-nhNMjoufiZRdn5LGxFqD_HA@mail.gmail.com>
 <CAHd499C_Z_npG3ibv_gJSU7kqrT6=DRCV8TU9_sjz9zzQ7vC-Q@mail.gmail.com>
 <54A7000A.3050605@kdbg.org>
 <CAHd499DpyO6Csji8gp1E6HsrvtBa7QMKBah2xOewrWAfNgQUHg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j6t@kdbg.org>, Git <git@vger.kernel.org>
To: Robert Dailey <rcdailey.lists@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 02 23:06:06 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y7AM9-0006pT-9h
	for gcvg-git-2@plane.gmane.org; Fri, 02 Jan 2015 23:06:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752641AbbABWGA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Jan 2015 17:06:00 -0500
Received: from mail-ie0-f173.google.com ([209.85.223.173]:44656 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752249AbbABWGA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Jan 2015 17:06:00 -0500
Received: by mail-ie0-f173.google.com with SMTP id y20so17079838ier.4
        for <git@vger.kernel.org>; Fri, 02 Jan 2015 14:05:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=vchlaQVcRNxr0kcrXqBFL5VpUYPy6cGzGOdtKkd26rs=;
        b=lWVSvS22eKdTRQ9Ug6cbTKv19OhgyNWB8nR5hQZ30ARVaUTMJS1HaN9iqF7F/PD9j+
         hBILd2KDitc14qVBX+z4BANm/9pjIj9v5T7X5rMNcPU2eAN2xVJsdtR6c1knUbMpcU8A
         P2gGlyZYAMcBgz2rT69CA++s0fQN93twkOzJtS/b8Vche9bctop49LZBr4NT4BMSi1hL
         CmYx2uy7m9QtdkvanBcJiK5LHl9HdNZPydTuCFFQW+3VfskVLu5lLCpDY6psHfxNfR0U
         plw62QQtvrUq0+ktW3qK05k66i3l7dl2GeCAS6GV7U93+Jniw+iI0bTnXibIOoZJvp85
         tkUA==
X-Received: by 10.43.100.67 with SMTP id cv3mr59399683icc.92.1420236359365;
        Fri, 02 Jan 2015 14:05:59 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:4dc:a2d1:6dcb:ef51])
        by mx.google.com with ESMTPSA id v83sm23363869iov.30.2015.01.02.14.05.58
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 02 Jan 2015 14:05:58 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAHd499DpyO6Csji8gp1E6HsrvtBa7QMKBah2xOewrWAfNgQUHg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261988>

Robert Dailey wrote:

> The 'void' does not start on the leftmost column, due to tabbing there
> can be any number of whitespace (the regex should account for this).

Ah, that explains it.  The default C++ pattern assumes the 'void'
starts at the leftmost column, so that the funcname header represents
whatever top-level construct forms the context (e.g., "class foo {").

(Jump targets or access declarations)
!^[ \t]*[A-Za-z_][A-Za-z_0-9]*:[[:space:]]*($|/[/*])

(functions/methods, variables, and compounds at top level)
^((::[[:space:]]*)?[A-Za-z_].*)$

Thanks,
Jonathan
