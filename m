From: Catalin Pol <catalin.pol@gmail.com>
Subject: Re: a small git proposal
Date: Fri, 24 Aug 2012 15:56:08 +0300
Message-ID: <CACZFoOFPohLCs-3QY97TUEZCxq-qV0cNW408rEQ0exws37Pdrw@mail.gmail.com>
References: <CACZFoOGjRX_CT5hpYcqN4_67he5gyAC-oGaPwZfcOx6w4QuxVQ@mail.gmail.com>
	<CAE1pOi0MXhQyKBa=s0ecwzUZhNkYcCA-_pwM0VC7vx9ECFrG0Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Hilco Wijbenga <hilco.wijbenga@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 24 14:56:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T4tQy-0001LY-GH
	for gcvg-git-2@plane.gmane.org; Fri, 24 Aug 2012 14:56:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759365Ab2HXM4L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Aug 2012 08:56:11 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:47216 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759339Ab2HXM4J (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Aug 2012 08:56:09 -0400
Received: by obbuo13 with SMTP id uo13so4056503obb.19
        for <git@vger.kernel.org>; Fri, 24 Aug 2012 05:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=f/zTMd6TqVQjjFOpTKxOuOFVNYWZIqf0xhtyPM7MWVc=;
        b=gtrUADXEhPtpSaZhbTfhejDbAxIceSvnSuLFh4Vw3HEyHsN7PpJHmmgBYN3BX4oqag
         5f67hb1BjlRJDs03/nvNU9zKqyv5mrz+In5TaWFn+57wR1sRr6zA5kpubjsDQ8TZJjIZ
         9sN9J8k4S0K7lFUr1wmTKiaGBjnTxK14n6071c9pWOVAzsOxLx0M2fwItJsKwVq3eKFI
         X0m/blWYtySgkTVJpUIagO8m0ER7B/D6pe2BdEMVVp0r2W8Zxbu/h5RAbpgM2CsxQh5I
         XI9vW+waZ4g9tosOqt3KjR+tmvwy91K/gtNaIFZl0pX3xkENhn3H3gSmhV6P+z0IhFJ7
         1/KA==
Received: by 10.50.53.171 with SMTP id c11mr1987080igp.57.1345812968680; Fri,
 24 Aug 2012 05:56:08 -0700 (PDT)
Received: by 10.64.54.66 with HTTP; Fri, 24 Aug 2012 05:56:08 -0700 (PDT)
In-Reply-To: <CAE1pOi0MXhQyKBa=s0ecwzUZhNkYcCA-_pwM0VC7vx9ECFrG0Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204208>

Thanks for the tip. It should give me a good starting point for what
I'm about to do, since notes seem to be able to add comments for
objects without changing the commit tree (which was one of the things
I was aiming for and quite frankly, one of the parts that worried me
on the implementation side).

However, what I want to implement has a few differences:
    a) the flags I'm proposing form a limited set of strings, as I'm
interested in finding which files have a particular flag (I did
mention the idea to add comment as well when adding a certain flag,
but that was something extra, since most of the searching/listing was
around the set of flags of a certain file, not around the comment
itself... I can cook up some more usage and output examples if anyone
thinks it can clear things up). I realize this can be achieved by
using a sound naming convention (and a simple grep for a particular
prefix when listing all notes would handle the search by flag I
mentioned) - unfortunately, some other differences don't seem to be
covered as you'll see below
    b) I would like to have all subsequent versions of a file to
inherit the flags/tags of the original file, until specified
otherwise; in the original idea that a 'feature tag' (or 'flag' as I
keep calling them lately - seems a better name that 'feature tag')
remains on the file until someone decides that feature is no longer
implemented in the file (for example, a file implements a certain
technique since version 3 until version 15, when the implementation of
a particular method changed entirely). Unfortunately, what seems to be
a good choice to preserve a state of a file until not needed are
branches, but then I would need to have the same version of the file
on different branches (a file can have multiple flags after all, since
multiple features are usually implemented in a file)

Anyway, I just wanted to point out that the notes you suggested are
not quite what I was looking for, but it should be a good
implementation starting point, so again, lots of thanks.

Catalin Pol


On Thu, Aug 23, 2012 at 6:16 PM, Hilco Wijbenga
<hilco.wijbenga@gmail.com> wrote:
> On 23 August 2012 08:10, Catalin Pol <catalin.pol@gmail.com> wrote:
>> Hi everyone,
>>
>> This is my first email to this mailing list, so this may be somehow
>> too straight forward... the idea is that I was thinking to develop a
>> new feature in Git (although I'm kind of new to git myself).
>> I wrote a small description of what I intend to do and I figured I
>> could use some pointers (how I can improve it, any possible usage
>> scenarios you can think for it and so on). Details are available at
>> the gist link below or as attachment to this email (I zipped the text
>> file since it was more it is larger than 10k and I didn't want it to
>> get rejected by the email server... although it still might)
>>
>> gist link:    https://gist.github.com/3437530
>>
>> I made the gist public, so feel free to edit it directly... or, if you
>> prefer, just email me with any comments. I'm opened to any suggestion,
>> so feel free to send me any kind of comment (maybe I'm trying to
>> implement something that is already in git for example, and since I'm
>> a bit of a newbie in the git world, I didn't notice any way to obtain
>> my desired workflow).
>>
>> Thanks in advance for any feedback,
>
> Have you looked at "git notes"?
