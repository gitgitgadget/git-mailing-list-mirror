From: Ken Tanzer <ken.tanzer@gmail.com>
Subject: Re: git rm / format-patch / am fails on my file: patch does not apply
Date: Tue, 12 Nov 2013 16:26:49 -0800
Message-ID: <CAD3a31UVkNaPTCWCAbv0NwCOTE5_2A+P7-e28VRnk9Aopa6hcQ@mail.gmail.com>
References: <CAD3a31XPKsnuNE+szw7xgvaDrcxhKZ2jTDHKzTwdwtnCwFb_0w@mail.gmail.com>
 <xmqqhabilpzx.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, Philip Oakley <philipoakley@iee.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 13 01:27:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VgOIx-0004Uw-91
	for gcvg-git-2@plane.gmane.org; Wed, 13 Nov 2013 01:27:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754395Ab3KMA1c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Nov 2013 19:27:32 -0500
Received: from mail-pd0-f182.google.com ([209.85.192.182]:58437 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753603Ab3KMA1a (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Nov 2013 19:27:30 -0500
Received: by mail-pd0-f182.google.com with SMTP id y13so4842422pdi.41
        for <git@vger.kernel.org>; Tue, 12 Nov 2013 16:27:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=pBgmezOqs/AlpOolKm1QQ1s2TcjNWjoy+hT2kMqZaf0=;
        b=uc29CMsZhyqjWjKMJJ1yd+rOgyKEgfzyQ8r5Nj52rO0/ucooCSstvI+2XJRXrurRaI
         yZfHcqvX/T9Yr4Wc1/qJalwqb+d225j9S93rEtKl9PcKaftxUEb7Vti/rbeXAiG2xfJX
         Ax/RpnMOv+u6/Jb7YX5v9SwaZMAMEyvNr27rmaHa4FyIgbhJv96gKIGv56DxhgAWbeXg
         pMMnA/SgFfM8+6hEfDyMa1LGTAvj+F8VuQcZnYxPCCyJZLPGNfa09X3WmH1GAOgioI9c
         LkbPXi65J0D+D7iE8LBKv1byoUnzSiBT3a7LGGPNNZOJzMsBKeBjRz+k68uophu4oJe6
         zR5A==
X-Received: by 10.68.130.39 with SMTP id ob7mr15253508pbb.63.1384302449898;
 Tue, 12 Nov 2013 16:27:29 -0800 (PST)
Received: by 10.66.227.170 with HTTP; Tue, 12 Nov 2013 16:26:49 -0800 (PST)
In-Reply-To: <xmqqhabilpzx.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237768>

> I am not very much surprised if such a file misbehaves, because the
> "format-patch | am" pipeline is designed to be used on patches that
> can be transferred in plain-text e-mail safely.  Long lines should
> probably be OK, but mixed CRLF, CR and LF may be problematic.

I'm not sure I understand this comment.  format-patch seems to work
fine on binary files.  So if it can handle any random collection of
bytes, why not text files with (admittedly funky) CRs and LFs?

Cheers,
Ken

On Mon, Nov 11, 2013 at 11:04 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Ken Tanzer <ken.tanzer@gmail.com> writes:
>
>> ASCII text, with very long lines, with CRLF, CR, LF line terminators
>
> I am not very much surprised if such a file misbehaves, because the
> "format-patch | am" pipeline is designed to be used on patches that
> can be transferred in plain-text e-mail safely.  Long lines should
> probably be OK, but mixed CRLF, CR and LF may be problematic.
>
> Having said that...
>
>> I've confirmed with the following test case on three machines, so it
>> seems reproducible:
>>
>> mkdir temp_test_case
>> cd temp_test_case
>> git init
>> # my file.  Sorry--couldn't find a saner link!
>> wget -O jquery-ui-1.8.custom.min.js
>> http://sourceforge.net/p/agency/code/ci/9358ea4dbe8e1540ec0b8bebfc7770f1bf8be0ec/tree/jquery-ui-1.8.custom.min.js?format=raw
>> git add jquery-ui-1.8.custom.min.js
>> git commit -m 'Adding jquery-ui'
>> git rm jquery-ui-1.8.custom.min.js
>> git commit -m 'Removing jquery-ui'
>> git format-patch HEAD~1
>> git reset --hard HEAD~1
>> git am 0001*
>
> ... this does not break at all for me.



-- 
AGENCY Software
A data system that puts you in control
100% Free Software
http://agency-software.org/
ken.tanzer@agency-software.org
(253) 245-3801

Subscribe to the mailing list to
learn more about AGENCY or
follow the discussion.
