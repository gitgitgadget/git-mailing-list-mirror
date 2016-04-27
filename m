From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] http: Support sending custom HTTP headers
Date: Wed, 27 Apr 2016 13:56:47 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1604271355350.2896@virtualbox>
References: <abe253758829795c285c2036196ebe7edd9bab34.1461589951.git.johannes.schindelin@gmx.de> <xmqq7fflleau.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1604260851390.2896@virtualbox> <20160426173853.GB7609@sigill.intra.peff.net>
 <alpine.DEB.2.20.1604270830220.2896@virtualbox> <20160427075219.GA32535@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Apr 27 13:57:34 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avO60-0001mf-S4
	for gcvg-git-2@plane.gmane.org; Wed, 27 Apr 2016 13:57:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753871AbcD0L5L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Apr 2016 07:57:11 -0400
Received: from mout.gmx.net ([212.227.15.15]:60136 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753405AbcD0L5I (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Apr 2016 07:57:08 -0400
Received: from virtualbox ([37.24.143.127]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0MA9Yv-1ap1Eu3wUL-00BKoo; Wed, 27 Apr 2016 13:56:50
 +0200
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <20160427075219.GA32535@sigill.intra.peff.net>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:ObkURBRV/uWHnG5gqmkEkzMx0rxj27oHrjNLyKcT++4KWyQemkH
 80ZKFM4nAGYCd4AhJG+fhKT6FrhGa4/HY3mdHN7Uh8ahJ7jlIwkYGzFPDXjD0Z7D5SUfdem
 hvDH0yicF6SQesyuMb32CrfE9YGA0MNmK7s6ppNp0CEJejrl6W0ILPOhSDlTZFDilwFm5fa
 E4L0I6+SFlF6wO97a2OOg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:98Y+Dz0d2LA=:DAfw4tVorh33KZyylEoDHw
 vVj2Ul2owrdfcWOaI77cNGjYnBfvUxmhOE8J0S3RweIXjJugUrVIhgRy2m1VAP9qa4nRTa2At
 sAH1hBtUcQX+9Fh9dWPDJ5oaoN/DiPQJva1FvTxqwUM9Q3jH0oMPiBU2GMNopHc5zipv5k6E2
 eDrWQB4erkIsfRiOoYdspdtD39AKt4927pQet4M9LDGinaDAYKBkVua6CB5M8rm9qjdB92E6E
 PjdsHe6LVJHFz1fbUKN7UYG190DDhdc0FBpDCgM7QNlAiO7w0xp6KxiReYzgkh0Ru5kJBmSTe
 rxSW07BjcS5Hr60rGJHuNozxQmCrM7OsodyA2vPJAaySu8Anhxx7Fu2m4XmENphXZcL9U2z4z
 qG7j0h6d8ZeW/1sdNGR5YLRFtunbjqUku+3Xyb+DkHUE+Z+HQ+hFKWfsh1xIXouzTWZKVzGOR
 bHvugvj3+k2UsUNgz6p9EH2sp9wLEEktikcWzH2rL+cX7WdVBHH1UeV7DVJprAYCE6W4+iBMq
 kR8MKQP3dKGtEk6iaBzzG/gOl880eRh2Q2Yj7Fkkndbgk1eX85utVMdgOnWNUNhtTq9wWNjqb
 NPPdbh+/uSUdb/CDTQF2WTYk41RsQRjxz6ML4RnHUt6E5fHs7jX6f6pGrXN3/nquaWii7yNUj
 SgW2xd/jVyds2oHDQfwsoMiEu6UDKxNNouztcA8e3ewEGr75qaqeeQYsIV6PmAy9l/LRAsM9P
 aObEoifC0kqBfUPzLvUWQrAOk8Gw0glt3LazIKjC91rE7e+RFJWcoa0OQY7leiN/q7xWu+55 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292718>

Hi Peff,

On Wed, 27 Apr 2016, Jeff King wrote:

> On Wed, Apr 27, 2016 at 08:31:50AM +0200, Johannes Schindelin wrote:
> 
> > > +test_expect_success 'custom http headers' '
> > > +	test_must_fail git fetch "$HTTPD_URL/smart_headers/repo.git" &&
> > > +	git -c http.extraheader="x-magic-one: abra" \
> > > +	    -c http.extraheader="x-magic-two: cadabra" \
> > > +	    fetch "$HTTPD_URL/smart_headers/repo.git"
> > > +'
> > > +
> > >  stop_httpd
> > >  test_done
> > 
> > That's pretty easy.
> > 
> > After sleeping over the issue, I realized, though, that the test can use
> > the very same method *I* used to verify that the headers are sent: using
> > GIT_CURL_VERBOSE.
> > 
> > I hope you do not mind that I used this method instead.
> 
> TBH, I think mine is a little more robust, but I don't overly care
> either way.

Yes, you are correct, I only test that the header is sent twice, assuming
that exactly two HTTP requests are sent. Your test verifies that whatever
request is sent *requires* the header.

Will send out v4 with your test instead of mine in a few moments.

Thanks,
Dscho
