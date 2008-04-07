From: "Avery Pennarun" <apenwarr@gmail.com>
Subject: Re: Integration branching
Date: Mon, 7 Apr 2008 14:32:45 -0400
Message-ID: <32541b130804071132q24acff6an853730af4fc7273e@mail.gmail.com>
References: <b24851260804070602o11b93923m7ce7d79d5f59547b@mail.gmail.com>
	 <7vod8lpnpb.fsf@gitster.siamese.dyndns.org>
	 <b24851260804071118h4eaadef8i8313c5a4cb26495d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "Kai Hendry" <hendry@aplixcorp.com>
X-From: git-owner@vger.kernel.org Mon Apr 07 20:33:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jiw9u-0004Mv-Dn
	for gcvg-git-2@gmane.org; Mon, 07 Apr 2008 20:33:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751930AbYDGScv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Apr 2008 14:32:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751917AbYDGScu
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Apr 2008 14:32:50 -0400
Received: from fg-out-1718.google.com ([72.14.220.159]:33701 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751363AbYDGScu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Apr 2008 14:32:50 -0400
Received: by fg-out-1718.google.com with SMTP id l27so1543694fgb.17
        for <git@vger.kernel.org>; Mon, 07 Apr 2008 11:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=91vEKLAWXaq5KXiTqsulWMuBGIf9jVfWnEGoJOn36UM=;
        b=c3OV05fzBQQDKfz/mbIudma73n1//RodHg6qDL/DaEWUp5T9uDDq68OWh4S5Zdl8PZJbxG3l3wWGp2JHlhsOPUvJ0cETRjyYLmEa5v8Wjoe858R1tIIMeZsS1jNb7qrtM2e+Vb24P9GXZeeGboj01ogGItjfZB3YvZhfv7mUnc0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=hf30acSiOw1RKpGPJViKpNCdwzT+J1yCU8RSVHUfO7Ev0qH5eZy4ifQ37suW3lMEtTIP5TMl+vLWdVPq5CAH9y679CMTK0Acj5A/ln20fQwWI8uBKXTmSS6Dg7oz8iev91kdOMGi/MfXOJ3go6oServ7wLfzSjg82J7e/+whDTQ=
Received: by 10.82.170.3 with SMTP id s3mr8664503bue.18.1207593165407;
        Mon, 07 Apr 2008 11:32:45 -0700 (PDT)
Received: by 10.82.100.5 with HTTP; Mon, 7 Apr 2008 11:32:45 -0700 (PDT)
In-Reply-To: <b24851260804071118h4eaadef8i8313c5a4cb26495d@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78985>

On Mon, Apr 7, 2008 at 2:18 PM, Kai Hendry <hendry@aplixcorp.com> wrote:
> On Mon, Apr 7, 2008 at 6:41 PM, Junio C Hamano <gitster@pobox.com> wrote:
>  >  A set of big questions is how that git.webvm.net/srv/git/webkit-test
>  >  repository was prepared, what its history look like and how it relates to
>  >  the history your repository has.  I presume that that is different from
>  >  the repository you are pushing from (which is "x61:aplix/test/WebKit"
>  >  repository), but other than that you did not give any details to guess
>  >  further.
>
>  webkit-test was just a `git --bare init --shared` and completely empty
>  with I tried pushing (publishing) the changes to WebKit trunk.
>
>  With thanks,

Basically every git repository needs to be entirely self-sufficient,
that is, it should be possible to check out a copy without referring
to any external repositories.  So your initial push to an empty
repository will always upload all the objects, even if you pulled from
some other.

The good news is that if your friends who checked out of the main
repository want to try out your branch, it *won't* accidentally
download all the extra objects over again.  git will notice that they
already have the same objects (retrieved from the main repo) and
download only the new ones.

So yes, some space is "wasted" on your extra repo, but disk space is
cheap anyway (and you now have a backup of the main repo for free :))

Have fun,

Avery
