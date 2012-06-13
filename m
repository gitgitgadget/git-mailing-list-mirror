From: Shawn Pearce <spearce@spearce.org>
Subject: Re: git clone over HTTP returns 500 on invalid host name
Date: Wed, 13 Jun 2012 16:43:19 -0700
Message-ID: <CAJo=hJv-gbpOzTmP+uTHXvuQHaDiH0PTVXqURUhLrLcfO4YEiQ@mail.gmail.com>
References: <CAJo=hJuax3-x53HJT-s32euyf2=d57MsRCQWo6NZO3OL35+o7g@mail.gmail.com>
 <7vbokmg4qf.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 14 01:43:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SexE0-0004IO-C3
	for gcvg-git-2@plane.gmane.org; Thu, 14 Jun 2012 01:43:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754910Ab2FMXnk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 Jun 2012 19:43:40 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:35125 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754470Ab2FMXnk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 Jun 2012 19:43:40 -0400
Received: by dady13 with SMTP id y13so1727996dad.19
        for <git@vger.kernel.org>; Wed, 13 Jun 2012 16:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=Ph6d6q4up6vKbRODBu1Ec0jJhDIDDjcO9WQabJzRTAs=;
        b=QjiaEsqCvhd16b++l6aJHe8w+BKoZx79MAKUt3zkPCuQ6bpL1ApmSMJDteqwtPTkYN
         eFkscXxggqyiB4JfTV5H2WrzE2UybOLCVeRG7cjRrLezr+ND1QFs3CE8sjERt1eECpiK
         I+HASjySk4KcbAd/mJzBnrHkxGFxHToqbiWc0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding:x-gm-message-state;
        bh=Ph6d6q4up6vKbRODBu1Ec0jJhDIDDjcO9WQabJzRTAs=;
        b=QofS4Vu3nBptzZzJk76L09LXREhJJIfs1iDe8RXsQ1YImTFnxhRwExl8Jf+jyj4qJD
         DXe/vGtgxvHHE15GWP+HxgP+b74e6RDVbWz1ZVos8BJEfIvOZ1m2Af4z5kpXzDl9RvL9
         6UCB1kMW+tpHobalXkwQkbJfJlx931caXYJibY7i4t3ku9RC+NiwsCH3H0hsVH1i7FmF
         KqI+UKpBis1/bKGkvRRp8rbfh8z4CnpZMcyZjvCQNg5JKOltsVWZJyIzD7yfnZQJ3hRj
         QE2Nh3umwE67ht10y64MwH9HrQ01ikLFtqFCVk/hi/DthhU7h9bzGrbIJw63UFQ6rTFH
         2Izw==
Received: by 10.68.241.227 with SMTP id wl3mr1065064pbc.89.1339631019564; Wed,
 13 Jun 2012 16:43:39 -0700 (PDT)
Received: by 10.68.52.169 with HTTP; Wed, 13 Jun 2012 16:43:19 -0700 (PDT)
In-Reply-To: <7vbokmg4qf.fsf@alter.siamese.dyndns.org>
X-Gm-Message-State: ALoCoQkcL83pheRKgoRwxyRNb+jD2ErXVEs/2KllapDc3kLYrTqAkqllHzJzUWXSf6ncax9DB7tO
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199961>

On Wed, Jun 13, 2012 at 4:40 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Shawn Pearce <spearce@spearce.org> writes:
>
>> $ git clone https://this.host.does.not.exist/foo
>> Cloning into 'foo'...
>> error: The requested URL returned error: 500 while accessing
>> http://this.host.does.not.exist/foo/info/refs
>> fatal: HTTP request failed
>>
>>
>> Hmm. Telling me the host doesn't exist is more useful than 500:
>>
>> $ git clone git://this.host.does.not.exist/foo
>> Cloning into 'foo'...
>> fatal: Unable to look up this.host.does.not.exist (port 9418) (Name =
or
>> service not known)
>>
>>
>> Does anyone care about this other than me? =A0:-)
>
>
> $ git clone https://this.host.does.not.exist/foo
> Cloning into 'foo'...
> error: Couldn't resolve host 'this.host.does.not.exist' while accessi=
ng https://this.host.does.not.exist/foo/info/refs
> fatal: HTTP request failed
>
> What are we doing differently? =A0Perhaps you have a custom proxy tha=
t
> throws 500 back at you or something?

Grrr. Yes. Its the contrib/persistent-https proxy that is causing
this, and a url.insteadof in ~/.gitconfig that always uses it for
https:

  [url "persistent-https://"]
    insteadof =3D https://
