From: Amos King <amos.l.king@gmail.com>
Subject: Re: [PATCH][v2] http authentication via prompts (with correct line 
	lengths)
Date: Wed, 18 Mar 2009 17:41:36 -0500
Message-ID: <d8c371a80903181541g71696ae4xe65b7ae2ac3f4e97@mail.gmail.com>
References: <d8c371a80903162215k4c27762cva650ea64d7850afa@mail.gmail.com>
	 <7v8wn4u0ip.fsf@gitster.siamese.dyndns.org>
	 <alpine.LNX.1.00.0903171206490.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Wed Mar 18 23:51:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lk4bW-0001Gg-1I
	for gcvg-git-2@gmane.org; Wed, 18 Mar 2009 23:51:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754516AbZCRWto convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 18 Mar 2009 18:49:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753992AbZCRWto
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Mar 2009 18:49:44 -0400
Received: from mail-qy0-f118.google.com ([209.85.221.118]:52878 "EHLO
	mail-qy0-f118.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751604AbZCRWtn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Mar 2009 18:49:43 -0400
X-Greylist: delayed 484 seconds by postgrey-1.27 at vger.kernel.org; Wed, 18 Mar 2009 18:49:42 EDT
Received: by qyk16 with SMTP id 16so382346qyk.33
        for <git@vger.kernel.org>; Wed, 18 Mar 2009 15:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=m6jrgoyHiG4CuKsftHO9fo243nF10ioTJFz34h9pv+w=;
        b=S3vNSAuCnFpSnxW9y23ET82hD8h+4s8T+p0pYyP0KBNpGDTlqN+CcJIcSN3ux3/Zzs
         P8o2B20m9CZMPbLVj6DuYojytTDepPLYLMJ2H3aXNRjarCMlOsXQQFMF0DQ0lLdUQAOb
         AoqKjwvaazrccrJTQ+1G/Afi+fkl8j9M6qyCQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=fBMPuidswgsi49qeyOdeBMqipxKv8A2FGSNhbUEyn8RPKAhXNvrMNKXVFr68xLxEhy
         cLOWklaMlTEFB8SZDmTLlWeHeuIkZXQtcTAHVmgdMRUO1T8EFr/1LrKHF4mhkKYLaFwW
         CEjBpxt39qj8ZQqHS2/kXBtlbxJcEzaCIRj/M=
Received: by 10.229.84.5 with SMTP id h5mr1243936qcl.25.1237416096341; Wed, 18 
	Mar 2009 15:41:36 -0700 (PDT)
In-Reply-To: <alpine.LNX.1.00.0903171206490.19665@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113699>

I got push working.  I wanted to ask one thing before I submit.  I
know that it is nice to keep changes local.  There is a method in
remote.c called add_url, but it is not exposed.  Right now to keep the
changes local I moved the internals of that method inline, but is it
ok for me to expose that method instead?

Amos

PS - Junio sorry for the double send.  I didn't notice that we weren't
on the list.

On Tue, Mar 17, 2009 at 11:24 AM, Daniel Barkalow <barkalow@iabervon.or=
g> wrote:
> On Mon, 16 Mar 2009, Junio C Hamano wrote:
>
>> Amos King <amos.l.king@gmail.com> writes:
>>
>> > Junio,
>> >
>> > I'm working with Mike on the http auth stuff, and I was testing ou=
t
>> > your patch. =A0I can get it to work for fetch but push is giving m=
e some
>> > grief. =A0Looking through the code I noticed that online 219 of
>> > http-push.c that http_init is being called with NULL instead of a
>> > remote. =A0If I pass in the remote then there is no remotre-url. =A0=
I've
>> > been digging around and can't find where or when that is being set=
=2E
>> > It has been a while since I worked with C but I'd love to jump in =
and
>> > help out here. =A0Can you point me in the right direction to get t=
he
>> > remote->url[0] set for the http_auth_init to use?
>>
>> Daniel is the primary culprit who introduced the transport abstracti=
on,
>> and I think he muttered something about his work-in-progress that in=
volves
>> in some change in the API. =A0Perhaps he has some insights here?
>>
>> Naah. =A0I forgot that the transport abstraction on the fetch side i=
s much
>> more integrated but curl_transport_push() simply launches http-push.=
c that
>> has a world on its own. =A0Worse yet, "remote" in http-push.c is not=
 even
>> the "struct remote"; it is something private to http-push.c called "=
struct
>> repo".
>>
>> I am not sure how much work would be involved in converting (or if i=
t is
>> even worth to convert) http-push.c to fit better into the transport =
API,
>> but if that is feasible, it might be a better longer-term solution.
>
> I think it would be a good thing to do. With the new transport push
> method, it could even get support for updating the tracking refs that
> track the refs you changed, since I broke that out of the git-native
> protocol code and into the transport code.
>
> My guess is that converting http-push to be called in-process would
> actually be pretty easy, because the two sides don't look at the same=
 data
> currently. (Some things were tricky with fetch, because the same proc=
ess
> sometimes wants to do fetches multiple times, for getting tags; this =
isn't
> as big a deal.)
>
> I think it should just be a matter of breaking http-push's main() int=
o a
> function that deals with the http-push command line and a function th=
at
> does the work, setting up a header file like send-pack.h, and changin=
g
> transport.c to just call the function.
>
>> Right now, builtin-push.c does all the remote inspection and when
>> http-push is called, the latter gets the information at the lowest l=
evel
>> only; the higher level information such as what nickname was used by=
 the
>> user to initiate the "git push" process and whether the refspecs cam=
e from
>> the command line or from the config are all lost, which is quite sad=
=2E
>
> What I did short-term for the send-pack version was introduce an opti=
onal
> command line argument, "--remote", that names the remote used, so the
> other program could get the configuration as well. It's a pretty easy
> step, but I don't think it's too worthwhile in this case.
>
>> But as a much lower impact interim solution, I suspect that you can =
fake a
>> minimally usable remote. =A0The http_push() codepath only cares abou=
t
>> remote->http_proxy and remote->url settings as far as I can tell, so
>> perhaps you can start (with a big warning that the remote you are cr=
eating
>> is a fake one) by filling the absolute minimum?
>>
>> That is, something along these lines (this comes on top of an obviou=
s
>> patch that renames existing "remote" variable in http-push. to "repo=
").
>>
>> diff --git a/http-push.c b/http-push.c
>> index dfbb247..f04ac74 100644
>> --- a/http-push.c
>> +++ b/http-push.c
>> @@ -2197,6 +2197,7 @@ int main(int argc, char **argv)
>> =A0 =A0 =A0 int new_refs;
>> =A0 =A0 =A0 struct ref *ref;
>> =A0 =A0 =A0 char *rewritten_url =3D NULL;
>> + =A0 =A0 struct remote *remote;
>>
>> =A0 =A0 =A0 git_extract_argv0_path(argv[0]);
>>
>> @@ -2258,12 +2259,14 @@ int main(int argc, char **argv)
>> =A0 =A0 =A0 if (!repo->url)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 usage(http_push_usage);
>>
>> + =A0 =A0 remote =3D remote_get(repo->url);
>> +
>> =A0 =A0 =A0 if (delete_branch && nr_refspec !=3D 1)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 die("You must specify only one branch na=
me when deleting a remote branch");
>>
>> =A0 =A0 =A0 memset(remote_dir_exists, -1, 256);
>>
>> - =A0 =A0 http_init(NULL);
>> + =A0 =A0 http_init(remote);
>>
>> =A0 =A0 =A0 no_pragma_header =3D curl_slist_append(no_pragma_header,=
 "Pragma:");
>
> This should work, although it obviously won't figure out the proxy fo=
r the
> configuration for the remote that was actually used.
>
> =A0 =A0 =A0 =A0-Daniel
> *This .sig left intentionally blank*
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>



--=20
Amos King
http://dirtyInformation.com
http://github.com/Adkron
--
Looking for something to do? Visit http://ImThere.com
