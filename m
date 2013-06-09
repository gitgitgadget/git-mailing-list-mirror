From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v4 06/45] Move sequencer to builtin
Date: Sun, 9 Jun 2013 12:06:40 -0500
Message-ID: <CAMP44s34-rq_jer5T8ovcbM4u+wsSSnd3RSQkK6yoEDqzEb9QA@mail.gmail.com>
References: <1370796057-25312-1-git-send-email-felipe.contreras@gmail.com>
	<1370796057-25312-7-git-send-email-felipe.contreras@gmail.com>
	<CALWbr2z_VArUi_4iKgdUgmUTA0hQ0EDF9ZuMs4RdEEZfnFOxMw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: Antoine Pelisse <apelisse@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 09 19:06:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ulj4p-0004hE-Bl
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 19:06:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751151Ab3FIRGn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Jun 2013 13:06:43 -0400
Received: from mail-la0-f43.google.com ([209.85.215.43]:33667 "EHLO
	mail-la0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751157Ab3FIRGm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 13:06:42 -0400
Received: by mail-la0-f43.google.com with SMTP id gw10so5089154lab.30
        for <git@vger.kernel.org>; Sun, 09 Jun 2013 10:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=x+0mOsHZKLYqCtmxWBLwhKAYaLun8AS+X3yGDjCN38E=;
        b=URcldtTA5+pvwLL0lMuSjB+TyC8G4P027YANKIOorCmd3TYyZsxAuwebrezJjQxFxE
         MKkijZ046t2fJuwbN6DbVzXI7+8A0tQbVBOF/+lDED02aq7W/D28HivZTzq3zuH4R59y
         6lHeP9ahXCHhU/9yzd+OySqxqYt5KBwIrMXqgd9snYfgrZ/iX2epLhpDZkMgukRZt2Fl
         yp/FNYm58cwevUILhN2U2+VLzDH6ML7rRWfD3UiJk7uuQmyBusZHXsowrvov8ep2mU5q
         BLPCTETMmt1A8rd5NE2OX0jC0voUxMA4IBlK7J3YqLhjjTzlqrLJdP4PIt5i9OR4ScmM
         WVdg==
X-Received: by 10.112.140.231 with SMTP id rj7mr5021647lbb.16.1370797600774;
 Sun, 09 Jun 2013 10:06:40 -0700 (PDT)
Received: by 10.114.59.202 with HTTP; Sun, 9 Jun 2013 10:06:40 -0700 (PDT)
In-Reply-To: <CALWbr2z_VArUi_4iKgdUgmUTA0hQ0EDF9ZuMs4RdEEZfnFOxMw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227022>

On Sun, Jun 9, 2013 at 12:02 PM, Antoine Pelisse <apelisse@gmail.com> wrote:
> On Sun, Jun 9, 2013 at 6:40 PM, Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
>>
>> This code is only useful for cherry-pick and revert built-ins, nothing
>> else, so let's make it a builtin object.
>>
>> The first source file that doesn't generate a git-foo builtin, but does
>> go into the builtin library. Hopefully the first of many to clean
>> libgit.a.
>
> Hey Felipe,
> I don't understand why the code doesn't belong to libgit.a, and how
> it's gonna make it more "clean". I can see that it is needed only by
> revert and cherry-pick, but is that the only reason ?
>
> Thanks for taking the time to enlighten me :)

A libgit library should be useful for things other than builtin
commands. Eventually libgit.a should be similar to libgit2, therefore
if libgit2 wouldn't want sequencer.c in it (it doesn't) neither should
we want this code in libgit.a. It belongs in builtin/lib.a.

If we don't start moving non-library stuff out of libgit.a, libgit.a
will never be a library.

-- 
Felipe Contreras
