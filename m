From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: [PATCH 1/4] test-suite: adding a test for fast-export with tag 
	variants
Date: Mon, 23 Mar 2009 01:55:15 +0100
Message-ID: <40aa078e0903221755n23457ba6m689aad34c0ec8214@mail.gmail.com>
References: <1237758620-6116-1-git-send-email-kusmabite@gmail.com>
	 <7vfxh59in9.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Erik Faye-Lund <kusmabite@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 23 02:00:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LlYWJ-0003Yb-RG
	for gcvg-git-2@gmane.org; Mon, 23 Mar 2009 02:00:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753973AbZCWAzU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 22 Mar 2009 20:55:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752085AbZCWAzU
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Mar 2009 20:55:20 -0400
Received: from ey-out-2122.google.com ([74.125.78.27]:36150 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751719AbZCWAzS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 22 Mar 2009 20:55:18 -0400
Received: by ey-out-2122.google.com with SMTP id 4so464225eyf.37
        for <git@vger.kernel.org>; Sun, 22 Mar 2009 17:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=ALBNt0dvd3zz2gbd1o089a8PQFkeXHfkkmGndHpQ9UA=;
        b=qFrXVf8pM93HU/DXlFbZ4NIMaHkoYvvb9cnfr0OwQOfISP2HzgkWlvdiTq9jxd4qEW
         5m8KavawYfHh8E00HSMo5YQHephOPMlEZUysIQT1+vKW7Jw0d65WbgNbiu+saEQqrNYv
         LnLQua6abk1cSWGQ3J8nbHsVoR1ed9Gq8Sci0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=slUu/tRlMxuzh7aAbmjgUD5QSkFlnnajDUhlc6DsYR5fC4lrsSfUAQanJnfj6f5Sm6
         1ala+cWd4PvJS2MnbtcJysGzeYtVDNTu+g3PXN8pe5iw72MPbURxXElodZsNebqWA8JE
         IkDvh90QjpZCzosc96pzDy/wKl2gL1x2gVnSE=
Received: by 10.210.21.13 with SMTP id 13mr1840953ebu.52.1237769715910; Sun, 
	22 Mar 2009 17:55:15 -0700 (PDT)
In-Reply-To: <7vfxh59in9.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114217>

On Mon, Mar 23, 2009 at 1:39 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
>> diff --git a/t/t9302-fast-export-tags.sh b/t/t9302-fast-export-tags.=
sh
>> new file mode 100644
>
> Make it executable if you need to add a new script, but shouldn't the=
se
> small tests be done as an addition to existing t9301, not as a brand =
new
> script?

Sure, will do. I just have to figure out how to make it executable in w=
indows ;)

As this is my first test, I was wondering a bit about how much I could
depend on the state of the repo, so I was a bit reluctant to add it to
the same test. But I guess it's easier for everyone in the long term
to put it into the same test, so I'll give it a go.

>> +test_expect_success 'tree_tag' =A0 =A0 =A0 =A0'git fast-export tree=
_tag'
>> +test_expect_success 'tree_tag-obj' =A0 =A0'git fast-export tree_tag=
-obj'
>> +test_expect_success 'tag-obj_tag' =A0 =A0 'git fast-export tag-obj_=
tag'
>> +test_expect_success 'tag-obj_tag-obj' 'git fast-export tag-obj_tag-=
obj'
>> +
>> +test_done
>
> The purpose of the first patch that adds tests is to expose existing
> problems, and it is better to say test_expect_failure in them. =A0Lat=
er
> patch to fix these issues will contain code change and also change to=
 flip
> some of the expect_failure to expect_success, and that way we can see=
 what
> issue is fixed with which patch more easily.

Sure, will do. I was a bit lazy, but updating it as we go will make
stuff easier in the future.

> These tests seem to only care about fast-export not dying, but don't =
we
> also want to check if they produce correct results?

Well, yeah. But I was working mainly on fixing a crash-bug here, and I
don't think I know enough about the correct output of fast-export to
pull this off. Perhaps tighting up the test is something someone else
would care to do?

--=20
Erik "kusma" Faye-Lund
kusmabite@gmail.com
(+47) 986 59 656
