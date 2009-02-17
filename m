From: John Tapsell <johnflux@gmail.com>
Subject: Re: [PATCH 1/2] Modify description file to say what this file is
Date: Wed, 18 Feb 2009 08:31:08 +0900
Message-ID: <43d8ce650902171531r47bd79cco1524ec883e4c6114@mail.gmail.com>
References: <200902171012.06176.johnflux@gmail.com>
	 <7vvdr852nj.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 18 00:32:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZZQd-0007PO-8h
	for gcvg-git-2@gmane.org; Wed, 18 Feb 2009 00:32:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752847AbZBQXbM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Feb 2009 18:31:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751953AbZBQXbK
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Feb 2009 18:31:10 -0500
Received: from yx-out-2324.google.com ([74.125.44.28]:18989 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751759AbZBQXbJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Feb 2009 18:31:09 -0500
Received: by yx-out-2324.google.com with SMTP id 8so1202446yxm.1
        for <git@vger.kernel.org>; Tue, 17 Feb 2009 15:31:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=K7LohHus5c0DRPbFdepIl9lmRqsTropZ2rsk1s+U57Q=;
        b=ZwDdYGlMip+Uh48j3/d1NlLy/nAAARPpY33GJB7q3bTsSX99wCEm1HL77zbzAqx69D
         ihMkZ/YoFnSW+QdYeHz++MlXHdtQ9kMLzI4xs+0whKfSJutbFxQxMBzwwcZLo1pB5jmP
         YvY41XLHtVwwMvwlaetFKOMfhzLemvfjhz2sg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Qd7mTE0lh8u+mhQivLBntHe++jl/8DT1WrnraI7X8x+0aa0Yey3dsutd9JqiTEY0/g
         I53C2rAmW7VI0cezEwc7g80hW5vPz+UrQghvmoDp/wXIcwLHv1EDcmkvdEC9PpdoYStd
         pjYY4aaexLBQ56lIJ9hLUPtiaEknZjpgYwX1w=
Received: by 10.151.144.4 with SMTP id w4mr501899ybn.170.1234913468596; Tue, 
	17 Feb 2009 15:31:08 -0800 (PST)
In-Reply-To: <7vvdr852nj.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110473>

2009/2/18 Junio C Hamano <gitster@pobox.com>:
> John Tapsell <johnflux@gmail.com> writes:
>
>> A lot of people see this message for the first time on the gitweb
>> interface, where there is no clue as to what 'this file' means.
>>
>> Signed-off-by: John Tapsell <johnflux@gmail.com>
>
> Thanks.
>
>> diff --git a/templates/hooks--update.sample b/templates/hooks--update.sample
>> index 93c6055..f753d28 100755
>> --- a/templates/hooks--update.sample
>> +++ b/templates/hooks--update.sample
>> @@ -43,10 +43,11 @@ allowdeletetag=$(git config --bool hooks.allowdeletetag)
>>
>>  # check for no description
>>  projectdesc=$(sed -e '1q' "$GIT_DIR/description")
>> -if [ -z "$projectdesc" -o "$projectdesc" = "Unnamed repository; edit this file to name it for gitweb." ]; then
>> +case $projectdesc in "Unnamed repository;"*|'')
>>       echo "*** Project description file hasn't been set" >&2
>>       exit 1
>> -fi
>> +     ;;
>> +esac
>
> "case" certainly makes it easier to read,
Using case is a 'hack' to let me check if a string begins with another
string, in a way that works in all shells (i.e. without bash
manarisims)

> but please start a case arm on a fresh line, like this:
>
>        case $projectdesc in
>        "Unnamed repository;"* | '')
>                echo "*** Project description ..."
>                exit 1
>                ;;
>        esac
>
>>  # --- Check types
>>  # if $newrev is 0000...0000, it's a commit to delete a ref.
>> diff --git a/templates/this--description b/templates/this--description
>> index c6f25e8..914a64e 100644
>> --- a/templates/this--description
>> +++ b/templates/this--description
>> @@ -1 +1 @@
>> -Unnamed repository; edit this file to name it for gitweb.
>> +Unnamed repository; edit the .git/description file to name it for gitweb.
>
> I do not have a fundamental objection to this line of changes.  If anybody
> is relying on the exact wording so be it.
>
> But ".git/description" is not typically the user has to edit to remedy
> this situation, because the primary target for both gitweb and git-push is
> a bare repository.  I think it is better to say "edit the 'description'
> file to name it for gitweb."

Btw, google seems to show other programs using the description file,
not just gitweb.  How about changing it to "Unnamed repository: edit
the file 'description' to name the repository" ?
