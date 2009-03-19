From: Amos King <amos.l.king@gmail.com>
Subject: Re: [PATCH 2/2] Allow http authentication via prompt for http push.
Date: Thu, 19 Mar 2009 18:22:14 -0500
Message-ID: <d8c371a80903191622i285211d1rebb57854c93babf3@mail.gmail.com>
References: <d8c371a80903190812w59febbd3qc6bc3d70ce85f76e@mail.gmail.com>
	 <alpine.DEB.1.00.0903191755270.6357@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 20 00:23:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LkRaV-0003sk-2t
	for gcvg-git-2@gmane.org; Fri, 20 Mar 2009 00:23:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757199AbZCSXWU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 19 Mar 2009 19:22:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752814AbZCSXWU
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Mar 2009 19:22:20 -0400
Received: from mail-qy0-f118.google.com ([209.85.221.118]:55345 "EHLO
	mail-qy0-f118.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754227AbZCSXWT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Mar 2009 19:22:19 -0400
Received: by qyk16 with SMTP id 16so1002699qyk.33
        for <git@vger.kernel.org>; Thu, 19 Mar 2009 16:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=q5ZIC9wbxdk+xs5IMwNPvV+xcA4yawrlJvosi1D/LAI=;
        b=fWFbZ7fAWeD2PjAox137Cof/bRePZ0xNpBdzl7qj88k4iKLbPBPWJcH7n/p/tsDzZk
         qJKCB3z0R+9R1aTprHzDrEFeCNytcCic6BOJpm2RdCTjm4Rd2KQNS9U4zgGeqkNtD6hi
         t5ZF1Jlby1kLUooD14Cfjts+31adthGlM9zgA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        b=CH6MlhzpiSnT3RNpEeG2jJ2OcBLEBvlbcKYJfyXCw4rbo5dFYJ3yF51rQKvsIjg6sm
         +Ww5IMC/pciGXmGfQwsCkEYNDVXylVedMnZQjVQdPAeEmlsZ6zL52xOn57oqHKQGkIQx
         dNIsVgTK2MRKiSc2Ts5KoWLPnv7ThEUh9282o=
Received: by 10.229.81.139 with SMTP id x11mr1956330qck.14.1237504934944; Thu, 
	19 Mar 2009 16:22:14 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0903191755270.6357@intel-tinevez-2-302>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113861>

Sorry for the way I responded.  It was not very appropriate of me.  I
do think that if you would take a little tact in your approach that
you would keep developers trying to improve the code they are putting
into git, and trying to contribute more often.

Amos

On Thu, Mar 19, 2009 at 11:59 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Thu, 19 Mar 2009, Amos King wrote:
>
>> There is now a faux remote created in order to
>> be passed to http_init.
>>
>> Signed-off-by: Amos King <amos.l.king@gmail.com>
>> ---
>> =C2=A0http-push.c | =C2=A0 11 ++++++++++-
>> =C2=A01 files changed, 10 insertions(+), 1 deletions(-)
>>
>> diff --git a/http-push.c b/http-push.c
>> index 9ac2664..468d5af 100644
>> --- a/http-push.c
>> +++ b/http-push.c
>> @@ -2195,7 +2195,16 @@ int main(int argc, char **argv)
>>
>> =C2=A0 =C2=A0 =C2=A0 memset(remote_dir_exists, -1, 256);
>>
>> - =C2=A0 =C2=A0 http_init(NULL);
>> + =C2=A0 =C2=A0 /*
>> + =C2=A0 =C2=A0 =C2=A0* This is a faked remote so that http_init can
>> + =C2=A0 =C2=A0 =C2=A0* get the correct data for builidng out athori=
zation.
>> + =C2=A0 =C2=A0 =C2=A0*/
>
> You might want to pass this through aspell ;-) =C2=A0Altough it will =
not
> suggest 'out ->our', I guess...
>
>> + =C2=A0 =C2=A0 struct remote *remote;
>> + =C2=A0 =C2=A0 remote =3D xcalloc(sizeof(*remote), 1);
>> + =C2=A0 =C2=A0 ALLOC_GROW(remote->url, remote->url_nr + 1, remote->=
url_alloc);
>> + =C2=A0 =C2=A0 remote->url[remote->url_nr++] =3D repo->url;
>> +
>> + =C2=A0 =C2=A0 http_init(remote);
>
> Would 'fake' not be a more appropriate name than 'remote'?
>
> That would also make the patch 1/2 rather unnecessary (I also have to
> admit that I do not find 'repo' a better name, as we have a repositor=
y
> both locally and remotely, and this _is_ the remote repository, not t=
he
> local one).
>
> Ciao,
> Dscho
>
>



--=20
Amos King
http://dirtyInformation.com
http://github.com/Adkron
--
Looking for something to do? Visit http://ImThere.com
